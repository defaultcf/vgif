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
    it "renders a successful response" do
      sign_in user
      get new_gif_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      sign_in user
      gif = create(:gif, user: user)
      get edit_gif_url(gif)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      before do
        sign_in user
      end

      it "creates a new Gif" do
        expect {
          post gifs_url, params: { gif: attributes_for(:gif) }
        }.to change(Gif, :count).by(1)
      end

      it "redirects to the created gif" do
        post gifs_url, params: { gif: attributes_for(:gif) }
        expect(response).to redirect_to(gif_url(Gif.order(:created_at).last))
      end
    end

    context "with invalid parameters" do
      before do
        sign_in user
      end

      it "does not create a new Gif" do
        expect {
          post gifs_url, params: { gif: attributes_for(:gif, title: nil) }
        }.to change(Gif, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post gifs_url, params: { gif: attributes_for(:gif, title: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
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
  end

  describe "DELETE /destroy" do
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
end
