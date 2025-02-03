import '../models/models.dart';
import '../models/attachment_models.dart';

final List<dynamic> mockPosts = [
  // Regular posts
  Post(
    id: '1',
    author: const UserInfo(
      id: '1',
      username: 'tech_enthusiast',
      displayName: 'Tech Enthusiast',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    content:
        'Just launched my new app! 🚀 Check out our landing page and demo video #coding #tech',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    attachments: const [
      AttachmentLink(url: 'https://myawesomeapp.com'),
      AttachmentVideo(
        url: 'https://example.com/demo.mp4',
        thumbnailUrl: 'https://picsum.photos/500/300?random=1',
        duration: Duration(minutes: 2, seconds: 30),
      ),
    ],
    hashtags: const ['coding', 'tech'],
    likes: 150,
    dislikes: 10,
    commentsCount: 45,
    sharesCount: 12,
    repostsCount: 8,
    quotesCount: 5,
  ),
  Post(
    id: '2',
    author: const UserInfo(
      id: '2',
      username: 'travel_enthusiast',
      displayName: 'Travel Enthusiast',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
    ),
    content:
        'Exploring the ancient ruins of Rome. History comes alive! 🏛️ Reading this amazing book about Roman architecture #travel #history #rome',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    attachments: const [
      AttachmentImage(
        url: 'https://picsum.photos/500/300?random=2',
        caption: 'The magnificent Colosseum at sunset',
      ),
      AttachmentBook(
        id: '978-0192801814',
        url: 'https://www.goodreads.com/book/show/1080924.Roman_Architecture',
        author: 'Frank Sear',
        coverUrl: 'https://picsum.photos/120/180?random=3',
        description:
            'A comprehensive study of Roman architectural history and techniques',
      ),
      AttachmentLocation(
        name: 'Colosseum',
        latitude: 41.8902,
        longitude: 12.4922,
        address: 'Piazza del Colosseo, 1, 00184 Roma RM, Italy',
        placeId: 'ChIJrRMgU7ZhLxMRxAOFkC7I8Sg',
      ),
    ],
    hashtags: const ['travel', 'history', 'rome'],
    likes: 200,
    dislikes: 15,
    commentsCount: 60,
    sharesCount: 18,
    repostsCount: 12,
    quotesCount: 6,
  ),
  Post(
    id: '3',
    author: const UserInfo(
      id: '3',
      username: 'foodie_adventures',
      displayName: 'Foodie Adventures',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
    ),
    content:
        'Made this delicious homemade pasta from scratch! 🍝 Following this amazing cookbook #cooking #foodie',
    createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    attachments: const [
      AttachmentImage(
        url: 'https://picsum.photos/500/300?random=4',
        caption: 'Fresh homemade fettuccine',
      ),
      AttachmentBook(
        id: '978-1416570189',
        url:
            'https://www.goodreads.com/book/show/2231384.Mastering_the_Art_of_French_Cooking',
        author: 'Julia Child',
        coverUrl: 'https://picsum.photos/120/180?random=5',
        description:
            'The classic cookbook that revolutionized American cuisine',
      ),
      AttachmentLocation(
        name: 'Italian Cooking School',
        latitude: 45.4642,
        longitude: 9.1900,
        address: 'Via Dante, 20121 Milano MI, Italy',
      ),
    ],
    hashtags: const ['cooking', 'foodie'],
    likes: 180,
    dislikes: 8,
    commentsCount: 35,
    sharesCount: 15,
    repostsCount: 10,
    quotesCount: 4,
  ),
  Post(
    id: '4',
    author: const UserInfo(
      id: '4',
      username: 'fitness_guru',
      displayName: 'Fitness Guru',
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
    ),
    content:
        'New workout video is up! 💪 Check out my latest HIIT routine #fitness #workout',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    attachments: const [
      AttachmentVideo(
        url: 'https://example.com/workout.mp4',
        thumbnailUrl: 'https://picsum.photos/500/300?random=6',
        duration: Duration(minutes: 15, seconds: 45),
      ),
      AttachmentLink(url: 'https://myfitnessblog.com/hiit-routine'),
      AttachmentLocation(
        name: 'Fitness First Gym',
        latitude: 51.5074,
        longitude: -0.1278,
        address: '123 Fitness Street, London, UK',
      ),
    ],
    hashtags: const ['fitness', 'workout'],
    likes: 250,
    dislikes: 12,
    commentsCount: 75,
    sharesCount: 25,
    repostsCount: 15,
    quotesCount: 8,
  ),
  Post(
    id: '5',
    author: const UserInfo(
      id: '5',
      username: 'art_lover',
      displayName: 'Art Lover',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
    ),
    content:
        'Just finished my latest painting! 🎨 Inspired by this amazing art history book #art #painting',
    createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    attachments: const [
      AttachmentImage(
        url: 'https://picsum.photos/500/300?random=7',
        caption: 'Abstract sunset in acrylics',
      ),
      AttachmentBook(
        id: '978-0714847030',
        url: 'https://www.goodreads.com/book/show/1312330.The_Story_of_Art',
        author: 'E.H. Gombrich',
        coverUrl: 'https://picsum.photos/120/180?random=8',
        description:
            'One of the most famous and popular books on art ever written',
      ),
    ],
    hashtags: const ['art', 'painting'],
    likes: 300,
    dislikes: 20,
    commentsCount: 90,
    sharesCount: 30,
    repostsCount: 18,
    quotesCount: 10,
  ),
];
