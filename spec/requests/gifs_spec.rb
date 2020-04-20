require 'rails_helper'

RSpec.describe "/gifs", type: :request do
  let(:user) { create(:user, email: 'test@example.com') }

  describe "GET /index" do
    it "renders a successful response" do
      create(:gif, user: user)
      get gifs_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      gif = create(:gif, user: user)
      get gif_url(gif)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it 'when not login, redirect login page' do
      get new_gif_url
      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders a successful response" do
      sign_in user
      get new_gif_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it 'when not login, redirect login page' do
      gif = create(:gif, user: user)
      get edit_gif_url(gif)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "render a successful response" do
      sign_in user
      gif = create(:gif, user: user)
      get edit_gif_url(gif)
      expect(response).to be_successful
    end

    it 'error when wrong user' do
      sign_in create(:user, email: 'user2@example.com')
      gif = create(:gif, user: user)
      get edit_gif_url(gif)
      expect(response).to render_template('errors/403')
    end
  end

  describe "POST /create" do
    let(:attributes) {
      attributes_for(:gif,
        image: fixture_file_upload(
          Rails.root.join('spec', 'factories', 'images', 'lulu_wink.gif'),
          'image/gif',
        ),
      )
    }
    # 一先ず20MBを上限とする
    let(:largefile) {
      fixture_file_upload(
        Rails.root.join('spec', 'factories', 'images', 'largefile_suichan.gif'),
        'image/gif',
      )
    }
    let(:jpegfile) {
      fixture_file_upload(
        Rails.root.join('spec', 'factories', 'images', 'me.jpg'),
        'image/jpeg',
      )
    }

    it 'when not login, redirect login page' do
      post gifs_url, params: { gif: attributes }
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with valid parameters" do
      before do
        sign_in user
      end

      it "creates a new Gif" do
        expect {
          post gifs_url, params: { gif: attributes }
        }.to change(Gif, :count).by(1)
      end

      it 'creates GIF with tags' do
        expect {
          post gifs_url, params: { gif: attributes.merge(tag_list: [{ value: '鈴原るる' }].to_json) }
        }.to change(ActsAsTaggableOn::Tag, :count).by(1)
      end

      it "redirects to the created gif" do
        post gifs_url, params: { gif: attributes }
        expect(response).to redirect_to(gif_url(Gif.order(:created_at).last))
      end

      it 'create with remote gif url' do
        stub_request(:any, 'https://j.gifs.com/OMz2yQ.gif')
          .to_return(
            headers: {
              'Content-Type': 'image/gif',
              'Content-Length': 1572864,
            },
            body: File.new(
              Rails.root.join('spec/factories/images/lulu_wink.gif'),
            ),
          )
        post gifs_url, params: { gif: attributes_for(:gif, remote_image_url: 'https://j.gifs.com/OMz2yQ.gif') }
        expect(response).to redirect_to(gif_url(Gif.order(:created_at).last))
      end
    end

    context "with invalid parameters" do
      before do
        sign_in user
      end

      it "does not create a new Gif" do
        expect {
          post gifs_url, params: { gif: attributes.merge(title: '') }
        }.to change(Gif, :count).by(0)
      end

      it 'large file cant upload' do
        expect {
          post gifs_url, params: { gif: attributes.merge(image: largefile) }
        }.to change(Gif, :count).by(0)
      end

      it 'jpeg file cant upload' do
        expect {
          post gifs_url, params: { gif: attributes.merge(image: jpegfile) }
        }.to change(Gif, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post gifs_url, params: { gif: attributes.merge(title: nil) }
        expect(response).to be_successful
      end

      it 'invalid remote image url' do
        post gifs_url, params: { gif: attributes_for(:gif, remote_image_url: '|ls') }
        expect(response).to render_template('gifs/new')
      end

      it 'remote image url includes not allowed host' do
        post gifs_url, params: { gif: attributes_for(:gif, remote_image_url: 'https://media.giphy.com/media/VgZ9vXZuDZBYOwdzGu/giphy.gif') }
        expect(response).to render_template('gifs/new')
      end
    end
  end

  describe "PATCH /update" do
    it 'when not login, redirect login page' do
      gif = create(:gif, user: user)
      patch gif_url(gif), params: { gif: { title: 'aaa' } }
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with valid parameters" do
      let(:new_attributes) {
        {
          title: 'this is new title'
        }
      }

      before do
        sign_in user
      end

      it "updates the requested gif" do
        gif = create(:gif, user: user)
        expect {
          patch gif_url(gif), params: { gif: new_attributes }
          gif.reload
        }.to change { gif.title }.to(new_attributes[:title])
      end

      it "redirects to the gif" do
        gif = create(:gif, user: user)
        patch gif_url(gif), params: { gif: new_attributes }
        gif.reload
        expect(response).to redirect_to(gif_url(gif))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        sign_in user
        gif = create(:gif, user: user)
        patch gif_url(gif), params: { gif: { title: '' } }
        expect(response).to be_successful
      end
    end

    it 'error when wrong user' do
      sign_in create(:user, email: 'user2@example.com')
      gif = create(:gif, user: user)
      patch gif_url(gif), params: { gif: { title: 'aaa' } }
      expect(response).to render_template('errors/403')
    end
  end

  describe "DELETE /destroy" do
    it 'when not login, redirect login page' do
      gif = create(:gif, user: user)
      delete gif_url(gif)
      expect(response).to redirect_to(new_user_session_path)
    end

    context 'when login' do
      before do
        sign_in user
      end

      it "destroys the requested gif" do
        gif = create(:gif, user: user)
        expect {
          delete gif_url(gif)
        }.to change(Gif, :count).by(-1)
      end

      it "redirects to the gifs list" do
        gif = create(:gif, user: user)
        delete gif_url(gif)
        expect(response).to redirect_to(gifs_url)
      end
    end

    it 'error when wrong user' do
      sign_in create(:user, email: 'user2@example.com')
      gif = create(:gif, user: user)
      delete gif_url(gif)
      expect(response).to render_template('errors/403')
    end
  end
end
