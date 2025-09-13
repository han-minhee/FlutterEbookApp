import 'package:flutter_ebook_app/src/common/common.dart';

/// Local book data from Project Gutenberg
class LocalBooksData {
  static List<Entry> get popularBooks => [
    _createBook(
      id: '1342',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      summary: 'A romantic novel of manners written by Jane Austen. The story follows the main character, Elizabeth Bennet, as she deals with issues of manners, upbringing, morality, education, and marriage in the society of the landed gentry of the British Regency.',
      coverImage: 'assets/images/pride_and_prejudice.jpg',
      downloadUrl: 'assets/books/pride_and_prejudice.txt',
      published: '1813-01-28',
      language: 'en',
      subjects: ['Romance', 'Fiction', 'Classic Literature'],
    ),
    _createBook(
      id: '11',
      title: "Alice's Adventures in Wonderland",
      author: 'Lewis Carroll',
      summary: 'A novel written by English author Charles Lutwidge Dodgson under the pseudonym Lewis Carroll. It tells of a young girl named Alice falling through a rabbit hole into a fantasy world populated by peculiar, anthropomorphic creatures.',
      coverImage: 'assets/images/alice_wonderland.jpg',
      downloadUrl: 'assets/books/alice_wonderland.txt',
      published: '1865-11-26',
      language: 'en',
      subjects: ['Fantasy', "Children's Literature", 'Adventure'],
    ),
    _createBook(
      id: '84',
      title: 'Frankenstein',
      author: 'Mary Wollstonecraft Shelley',
      summary: 'A Gothic novel written by English author Mary Shelley. The story tells of Victor Frankenstein, a young scientist who creates a hideous, sapient creature in an unorthodox scientific experiment.',
      coverImage: 'assets/images/frankenstein.jpg',
      downloadUrl: 'assets/books/frankenstein.txt',
      published: '1818-01-01',
      language: 'en',
      subjects: ['Gothic', 'Science Fiction', 'Horror'],
    ),
    _createBook(
      id: '1661',
      title: 'The Adventures of Sherlock Holmes',
      author: 'Arthur Conan Doyle',
      summary: "A collection of twelve short stories featuring the famous detective Sherlock Holmes and his companion Dr. Watson. These stories showcase Holmes' brilliant deductive reasoning and investigative skills.",
      coverImage: 'assets/images/sherlock_holmes.jpg',
      downloadUrl: 'assets/books/sherlock_holmes.txt',
      published: '1892-10-14',
      language: 'en',
      subjects: ['Mystery', 'Detective Fiction', 'Short Stories'],
    ),
    _createBook(
      id: '74',
      title: 'The Adventures of Tom Sawyer',
      author: 'Mark Twain',
      summary: 'A novel about a young boy growing up along the Mississippi River. The story is set in the fictional town of St. Petersburg, inspired by Hannibal, Missouri, where Twain lived as a boy.',
      coverImage: 'assets/images/tom_sawyer.jpg',
      downloadUrl: 'assets/books/tom_sawyer.txt',
      published: '1876-01-01',
      language: 'en',
      subjects: ['Adventure', 'Coming of Age', 'American Literature'],
    ),
    _createBook(
      id: '2701',
      title: 'Moby Dick',
      author: 'Herman Melville',
      summary: "An epic sea story of Captain Ahab's voyage in pursuit of Moby Dick, the legendary white whale. This novel is considered one of the greatest American novels ever written.",
      coverImage: 'assets/images/moby_dick.jpg',
      downloadUrl: 'assets/books/moby_dick.txt',
      published: '1851-10-18',
      language: 'en',
      subjects: ['Adventure', 'Sea Stories', 'American Literature'],
    ),
  ];

  static List<Entry> get recentBooks => [
    _createBook(
      id: '145',
      title: 'Middlemarch',
      author: 'George Eliot',
      summary: 'A novel set in the fictitious Midlands town of Middlemarch during 1829-1832. It follows the lives of several residents as they navigate love, politics, and social change.',
      coverImage: 'assets/images/middlemarch.jpg',
      downloadUrl: 'assets/books/middlemarch.txt',
      published: '1871-12-01',
      language: 'en',
      subjects: ['Romance', 'Social Commentary', 'Victorian Literature'],
    ),
    _createBook(
      id: '1400',
      title: 'Great Expectations',
      author: 'Charles Dickens',
      summary: 'The story of Pip, an orphan boy who rises from humble beginnings to become a gentleman in Victorian England. A tale of personal growth, love, and the true meaning of being a gentleman.',
      coverImage: 'assets/images/great_expectations.jpg',
      downloadUrl: 'assets/books/great_expectations.txt',
      published: '1861-08-01',
      language: 'en',
      subjects: ['Coming of Age', 'Victorian Literature', 'Social Commentary'],
    ),
    _createBook(
      id: '98',
      title: 'A Tale of Two Cities',
      author: 'Charles Dickens',
      summary: 'Set in London and Paris before and during the French Revolution, this novel tells the story of the French Doctor Manette and his daughter Lucie.',
      coverImage: 'assets/images/tale_two_cities.jpg',
      downloadUrl: 'assets/books/tale_two_cities.txt',
      published: '1859-11-26',
      language: 'en',
      subjects: ['Historical Fiction', 'Revolution', 'Drama'],
    ),
  ];

  static Entry _createBook({
    required String id,
    required String title,
    required String author,
    required String summary,
    required String coverImage,
    required String downloadUrl,
    required String published,
    required String language,
    required List<String> subjects,
  }) {
    return Entry(
      id: Id(t: id),
      title: Id(t: title),
      author: Author1(
        name: Id(t: author),
        uri: Id(t: 'local://author/$author'),
      ),
      summary: Id(t: summary),
      published: Id(t: published),
      updated: Id(t: DateTime.now().toIso8601String()),
      dctermsLanguage: Id(t: language),
      dctermsPublisher: Id(t: 'Project Gutenberg'),
      dctermsIssued: Id(t: published),
      category: subjects.map((subject) => Category(
        label: subject,
        term: subject.toLowerCase().replaceAll(' ', '_'),
        scheme: 'http://www.gutenberg.org/2009/pgterms/subject',
      )).toList(),
      link: [
        Link1(
          type: 'image/jpeg',
          rel: 'http://opds-spec.org/image',
          href: coverImage,
        ),
        Link1(
          type: 'image/jpeg',
          rel: 'http://opds-spec.org/image/thumbnail',
          href: coverImage,
        ),
        Link1(
          type: 'application/epub+zip',
          rel: 'http://opds-spec.org/acquisition',
          href: downloadUrl,
          title: 'EPUB',
        ),
      ],
    );
  }
}
