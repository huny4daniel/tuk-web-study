package my.model;

public class Book {
	private int bookId;
	private String name;
	private String author;
	private String isbn;
	private String publisher;
	private int price;
	private String image;

	public Book() {}

	public Book(String name, String author, String isbn, String publisher, int price, String image) {
		super();
		this.name = name;
		this.author = author;
		this.isbn = isbn;
		this.publisher = publisher;
		this.price = price;
		this.image = image;
	}

	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
}
