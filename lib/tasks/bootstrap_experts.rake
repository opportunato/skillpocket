namespace :bootstrap do
  desc "Populate experts"
  task :experts => :environment do
    User.destroy_all
    Skill.destroy_all
    Tag.destroy_all

    fixtures_path = Rails.root.join("db/fixtures/images")

    image = File.open "#{fixtures_path}/lera.png"
    banner = File.open "#{fixtures_path}/banner.jpeg"

    expert = User.create({
      full_name: 'Lera Moiseeva',
      email: 'lera@example.com',
      job: 'Independent Industrial Designer',
      about: "I am an industrial designer. I live in New York. I am originally from Russia. I got a degree in sociology and one in product design from IED Madrid. My family are space engineers and I’ve always been fascinated by images of the cosmos. I work with various materials such as porcelain, glass and wood, and aesthetics are strongly influence by the images of the space industry.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      price: "50",
      title: 'Building Your Own Micro-Brand As A Designer',
      expert: expert
    })

    skill.assign_tags('Branding', 'Design', 'Entrepreneurship', 'Industrial design')
  
    image = File.open "#{fixtures_path}/denis.png"

    expert = User.create({
      full_name: 'Denis Drachyov',
      email: 'denis@example.com',
      job: 'Product lead, Skillpocket',
      about: "I am the product lead of Skillpocket. I have been designing and developing websites for 5+ years. I was the Design Director of three companies within Dream Industries.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      price: "60",
      title: 'UI & UX Advise — Get feedback on your designs',
      expert: expert
    })

    skill.assign_tags('UX', 'Design', 'Usability', 'Product Design', 'Service Design')

    image = File.open "#{fixtures_path}/frederik.png"

    expert = User.create({
      full_name: 'Frederik Trovatten',
      email: 'frederik@example.com',
      job: 'CMO at Skillpocket',
      about: "I’ve been an online marketeer for 5+ years. I started out working for agencies, then moved into banking covering the PPC efforts in Eastern Europe and Southern America for SAXO Bank before joining Firmafon as their CMO, and later taking on that same role for a set of fast-growing educational startups in Moscow. Most my waking hours are spend doing internet marketing, like SEO, Google Adwords and Web Strategy for clients and a couple of private projects.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      price: "40",
      title: 'Growth hacking and SEO — tips, tricks and feedback on optimizing your site for growth',
      expert: expert
    })

    skill.assign_tags('SEO', 'Analytics', 'Online Marketing', 'Blogging')
    
    image = File.open "#{fixtures_path}/tiffany.png"

    expert = User.create({
      full_name: 'Tiffany Spencer',
      email: 'tiffany@example.com',
      job: 'Law Consultant at Companies House',
      about: "I have been a tax and company consultant for more than 7 years. I opened my first accounting company in the UK in 2004 and went through all the hassle and made all the mistakes myself so I know how important it is to have someone close who can help guide and save time.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      price: "100",
      title: 'Register Your Company In The UK',
      expert: expert
    })

    skill.assign_tags('Law', 'Company Structure', 'Private Limited', 'Incorporate', 'Tax Issues')
    
    image = File.open "#{fixtures_path}/geer.png"

    expert = User.create({
      full_name: 'Michael Geer',
      email: 'michael@example.com',
      job: 'COO at AnchorFree',
      about: "I Helped build Badoo to over 70 million users. Since then I joined Dream Industries as COO to develop their 3 major online companies, and now helps run AnchorFree to make sure everyone globally has secure access to all the world's information and keep the internet uncensored.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      price: "150",
      title: 'Planning For Virality & How You Get Your First Million Users',
      expert: expert
    })

    skill.assign_tags('Growth Hacking', 'Marketing', 'Virality', 'User Acquisition', 'Product Planning', 'Process Planning', 'JIRA')
    
    image = File.open "#{fixtures_path}/roman.jpg"

    expert = User.create({
      full_name: 'Roman Gordeev',
      email: 'roman@example.com',
      job: 'Developer at Skillpocket',
      about: "I’m a co-founder of Skillpocket and lead the back-end developments of our little adventure. Before that I led the development of Third-Place.ru and helped improve application interfaces for Kaspersky Lab.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      price: "70",
      title: 'Full-Stack Web Development: Assistance, Training and Consulting',
      expert: expert
    })

    skill.assign_tags('Front-End', 'Back-End', 'Ruby on Rails', 'Web Development', 'JavaScript', 'HTML', 'CSS')  end
end
