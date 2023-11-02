# README

## users
| Column             | Type       | Options                        |
| ------------------ | ------     | -----------                    |
| email              | string     | null:false, unique:true        |
| encrypted_password | string     | null:false                     |
| nickname           | string     | null:false                     |

### Association
- has_many :posts
- has_many :comments

## comments
| Column             | Type       | Options                       |
| ------------------ | ------     | -----------                   |
| content            | text       | null:false                    |
| user               | references | null:false, foreign_key: true |              
| post               | references | null:false, foreign_key: true |

### Association
- belongs_to :post
- belongs_to :user

## posts
| Column             | Type       | Options                       |
| ------------------ | ------     | -----------                   |
| content            | text       | null:false                    |
| user               | references | null:false, foreign_key: true |   

### Association
- has_many :post_tags
- has_many :tags, through: :post_tags
- belongs_to :user
- has_many :comments

## post_tags
| Column             | Type       | Options                       |
| ------------------ | ------     | -----------                   |
| post               | references | null:false, foreign_key: true |
| tag                | references | null:false, foreign_key: true |

### Association
- belongs_to :post
- belongs_to :tag

## tags
| Column             | Type       | Options                       |
| ------------------ | ------     | -----------                   |
| content            | text       | null:false                    |

### Association
- has_many :post_tags
- has_many :posts, through: :post_tags