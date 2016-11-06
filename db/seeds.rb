Shop.find_or_create_by(:name => 'YU-YU')

Menu.find_or_create_by(
    :name => 'イチゴパフェ',
    :picture => 'https://res.cloudinary.com/hmfnscv52/image/upload/v1477837218/kuehdcwcbdc49mfkpfij.png',
    :detail => 'あ',
    :category => 'デザート',
    :price => 400,
    :shop_id => Shop.where(:name => 'YU-YU').first.id
)

Menu.find_or_create_by(:name => 'うどん', :picture => 'https://res.cloudinary.com/hmfnscv52/image/upload/v1477837251/it6rsnvr999htz0k4mwh.png', :detail => 'あ', :category => '麺類', :price => 600, :shop_id => Shop.where(:name => 'YU-YU').first.id, :category_id => 1)
Menu.find_or_create_by(:name => 'そば', :picture => 'https://res.cloudinary.com/hmfnscv52/image/upload/v1477837286/eutr6extozlex5gfpynt.png', :detail => 'あ', :category => '麺類', :price => 500, :shop_id => Shop.where(:name => 'YU-YU').first.id, :category_id => 1)
Menu.find_or_create_by(:name => '天丼', :picture => 'https://res.cloudinary.com/hmfnscv52/image/upload/v1477837316/cqv23xsye53hb8inlgz6.png', :detail => 'あ', :category => '丼', :price => 800, :shop_id => Shop.where(:name => 'YU-YU').first.id, :category_id => 2)
Menu.find_or_create_by(:name => 'カレー', :picture => 'https://res.cloudinary.com/hmfnscv52/image/upload/v1477837346/eehwvt2exfnfleqhi4vi.png', :detail => 'あ', :category => '丼', :price => 700, :shop_id => Shop.where(:name => 'YU-YU').first.id, :category_id => 2)
Menu.find_or_create_by(:name => 'ラーメン', :picture => 'https://res.cloudinary.com/hmfnscv52/image/upload/v1477837372/d3fhvkxboxaujs4fatvw.png', :detail => 'あ', :category => '麺類', :price => 650, :shop_id => Shop.where(:name => 'YU-YU').first.id, :category_id => 1)
Menu.find_or_create_by(:name => 'プリン', :picture => 'https://res.cloudinary.com/hmfnscv52/image/upload/v1477841904/lhnqowtdser0mzqjkbr6.png', :detail => 'あ', :category => 'デザート', :price => 300, :shop_id => Shop.where(:name => 'YU-YU').first.id, :category_id => 3)
Menu.find_or_create_by(:name => 'ぜんざい', :picture => 'https://res.cloudinary.com/hmfnscv52/image/upload/v1477841934/cmxryowthlbybpsvxtai.png', :detail => 'あ', :category => 'デザート', :price => 450, :shop_id => Shop.where(:name => 'YU-YU').first.id, :category_id => 3)
Menu.find_or_create_by(:name => '牛丼', :picture => 'https://res.cloudinary.com/hmfnscv52/image/upload/v1477841959/cmqyhzdxrnsfkwl45qdh.png', :detail => 'あ', :category => '丼', :price => 550, :shop_id => Shop.where(:name => 'YU-YU').first.id, :category_id => 2)

