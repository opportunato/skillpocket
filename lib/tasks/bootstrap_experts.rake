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
      first_name: 'Lera',
      last_name: 'Moiseeva',
      job: 'Independent Industrial Designer',
      about: "I am an industrial designer. I live in New York. I am originally from Russia. I got a degree in sociology and one in product design from IED Madrid. My family are space engineers and I’ve always been fascinated by images of the cosmos. I work with various materials such as porcelain, glass and wood, and aesthetics are strongly influence by the images of the space industry.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      description: "Are you about to make your own brand as a designer and do you have questions or worries for how this might work? Having just opened my own brand and taken the first steps — producing my own productions, exhibiting them around the world and trying to get them out to the industry — I would love to share my experiences and advice for designers who are just starting out.",
      price: "50",
      title: 'Building Your Own Micro-Brand As A Designer',
      expert: expert
    })

    skill.assign_tags('Branding', 'Design', 'Entrepreneurship', 'Industrial design')
  
    image = File.open "#{fixtures_path}/denis.png"

    expert = User.create({
      first_name: 'Denis',
      last_name: 'Drachyov',
      job: 'Product lead, Skillpocket',
      about: "I am the product lead of Skillpocket. I have been designing and developing websites for 5+ years. I was the Design Director of three companies within Dream Industries.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      description: "A usable and engaging website is important for obtaining and retaining new users. I can evaluate your website for many of the most-common usability problems and offer suggestions on how to improve your site so that it better meets the needs of your users! Before our meeting, please send me a URL to your website or a .pdf with the designs of your future website. This will save us time so we can focus on talking about how to make your website even better!",
      price: "60",
      title: 'UI & UX Advise — Get feedback on your designs',
      expert: expert
    })

    skill.assign_tags('UX', 'Design', 'Usability', 'Product Design', 'Service Design')

    image = File.open "#{fixtures_path}/frederik.png"

    expert = User.create({
      first_name: 'Frederik',
      last_name: 'Trovatten',
      job: 'CMO at Skillpocket',
      about: "I’ve been an online marketeer for 5+ years. I started out working for agencies, then moved into banking covering the PPC efforts in Eastern Europe and Southern America for SAXO Bank before joining Firmafon as their CMO, and later taking on that same role for a set of fast-growing educational startups in Moscow. Most my waking hours are spend doing internet marketing, like SEO, Google Adwords and Web Strategy for clients and a couple of private projects.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      description: "Most who run a website, a blog, an e-commerce store or even a tech heavy startup don’t know how to properly get the traffic that their site should be able to generate. Often small tricks and seemingly incremental changes can have a huge effect on how Google reads your site, on how many users you’ll see from indirect sources, how the users you do get perform and all this is what I focus on. Before our meeting you should send me a link to your site so I can have a look and bring ideas to the table from the get go!",
      price: "40",
      title: 'Growth hacking and SEO — tips, tricks and feedback on optimizing your site for growth',
      expert: expert
    })

    skill.assign_tags('SEO', 'Analytics', 'Online Marketing', 'Blogging')
    
    image = File.open "#{fixtures_path}/tiffany.png"

    expert = User.create({
      first_name: 'Tiffany',
      last_name: 'Spencer',
      job: 'Law Consultant at Companies House',
      about: "I have been a tax and company consultant for more than 7 years. I opened my first accounting company in the UK in 2004 and went through all the hassle and made all the mistakes myself so I know how important it is to have someone close who can help guide and save time.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      description: "Are you planning to open a company in the UK and do you need help figuring out what type of organization would be best for you and your company? Send me a few notes on what you do and how you plan to grow before we meet and I will help you move fast through the most complex issues.",
      price: "100",
      title: 'Register Your Company In The UK',
      expert: expert
    })

    skill.assign_tags('Law', 'Company Structure', 'Private Limited', 'Incorporate', 'Tax Issues')
    
    image = File.open "#{fixtures_path}/geer.png"

    expert = User.create({
      first_name: 'Michael',
      last_name: 'Geer',
      job: 'COO at AnchorFree',
      about: "I Helped build Badoo to over 70 million users. Since then I joined Dream Industries as COO to develop their 3 major online companies, and now helps run AnchorFree to make sure everyone globally has secure access to all the world's information and keep the internet uncensored.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      description: "Learn concepts of viral user acquisition and the iterative product process of implementing those concepts. Relevant to anyone building or thinking about building an online project (emphasis is put on B2C).",
      price: "150",
      title: 'Planning For Virality & How You Get Your First Million Users',
      expert: expert
    })

    skill.assign_tags('Growth Hacking', 'Marketing', 'Virality', 'User Acquisition', 'Product Planning', 'Process Planning', 'JIRA')
    
    image = File.open "#{fixtures_path}/roman.jpg"

    expert = User.create({
      first_name: 'Roman',
      last_name: 'Gordeev',
      job: 'Developer at Skillpocket',
      about: "I’m a co-founder of Skillpocket and lead the back-end developments of our little adventure. Before that I led the development of Third-Place.ru and helped improve application interfaces for Kaspersky Lab.",
      photo: image,
      profile_banner: banner
    })

    skill = Skill.create({
      description: "Do you want to learn how to make a brand new web application? Do you need help with an existing project? Or would like help figuring out if Ruby on Rails is right for you? I'm here to help you with resolving your frontend and rails development problems or concerns.",
      price: "70",
      title: 'Full-Stack Web Development: Assistance, Training and Consulting',
      expert: expert
    })

    skill.assign_tags('Front-End', 'Back-End', 'Ruby on Rails', 'Web Development', 'JavaScript', 'HTML', 'CSS')  end
end