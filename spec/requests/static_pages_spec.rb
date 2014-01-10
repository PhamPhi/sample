require 'spec_helper'

describe "StaticPages" do
   subject {page}
   #
   # Testing for home page about title, content
   #
   describe  "Home Page" do
      before { visit root_path }
      it {  should have_content('Techie Blog')}
      it {  should have_title(full_title(''))}
      it {  should_not have_title('|Home') }

      # TestCase for User who was signed in to our systems,.
     describe "for signed-in users" do
       let(:user) { FactoryGirl.create(:user) }
       before do
         FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
         FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
         sign_in user
         visit root_path
       end

       it "should render the user's feed" do
         user.feed.each do |item|
           expect(page).to have_selector("li##{item.id}", text: item.content)
         end
       end

       describe "follower/following counts" do
         let(:other_user) { FactoryGirls.create(:user) }
         before do
           other_user.follow!(user)
           visit root_path
         end

         # It should have a link following users
         # It should have a link about the users's followers...
         it { should have_link("0 following", href: following_user_path(user)) }
         it { should have_link("1 followers", href: following_user_path(user))}
       end
     end
   end

    describe "Help Page" do
      before { visit help_path }
      it { should have_content('Help')}
      it { should have_title(full_title('Help'))}
    end

    describe "About Page" do
      before { visit about_path }
      it { should have_content('About')}
      it { should have_title(full_title('About Us'))}
    end

    describe "Contact Page" do
      before { visit contact_path}
      it { should have_content('Contact')}
      it { should have_title(full_title('Contact Us'))}
    end

end
