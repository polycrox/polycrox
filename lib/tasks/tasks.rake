
desc "update items-groups relationship"
task update_items_groups: :environment do 
  Item.all.each do |item|
    group = Group.find(item.item_group_id)
    item.groups << group
    item.save
  end
end

namespace :import do
  desc "import items and groups"
  task items_groups: :environment do
    File.open('last_export_items_groups.txt', 'r') do |f|
      f.read.each_line do |line|
        item_name, group_names = line.split(';')
        item = ItemBuilder.new(item_name: item_name, group_names: group_names.split(','))
        if Rails.env.production?
          item.save
          puts "."
        end
      end
    end
  end
end

namespace :export do 
  desc "export items and groups"
  task items_groups: :environment do
    File.open("export_items_groups_#{Time.now.to_i}.txt", 'w') do |f|
      Item.all.each do |item|
        f.write("#{item.name};#{item.groups.map {|g| g.name}.join(',')}\n")
      end
    end
  end

  desc "export form properties"
  task form_properties: :environment do
    File.open("export_form_properties_#{Time.now.to_i}.txt", "w") do |f|
      f.write("#name;html;options;multiple\n")
      FormProperty.all.each do |fp|
        f.write("#{fp.name};#{fp.html};#{fp.options};#{fp.multiple}\n")
      end
    end
  end
end