class AddAttachmentAvatarToProfiles < ActiveRecord::Migration[7.0]
  def self.up
    # To get this version to work, I had to edit the paperclip gem.
    # Start by running the migration with the `--trace` flag to see where the
    # error is coming from, then edit paperclip files as needed to use
    # `*options` instead of `options` (for example) to fix this breaking
    # change in Ruby 3.0:
    # https://www.ruby-lang.org/en/news/2019/12/12/separation-of-positional-and-keyword-arguments-in-ruby-3-0/
    # I changed this line: https://github.com/thoughtbot/paperclip/blob/c769382c9b7078f3d1620b50ec2a70e91ba62ec4/lib/paperclip/schema.rb#L54
    # TODO: Forget about all the patching and replace paperclip
    #       (which is deprecated) with ActiveStorage
    change_table :profiles do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :profiles, :avatar
  end
end
