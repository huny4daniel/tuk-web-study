package my.model;

public class Cart {
	private String customer;
	private int bookId;
	private int price;
	private int amount;
	
	public Cart(String customer, int bookId, int price, int amount) {
		super();
		this.customer = customer;
		this.bookId = bookId;
		this.price = price;
		this.amount = amount;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	

}
