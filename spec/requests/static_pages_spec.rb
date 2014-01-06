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
