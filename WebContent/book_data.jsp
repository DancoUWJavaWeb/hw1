<%!
	class Book {
		String title;
		String author;
		String genre;
		double price;
		String description;
		
		Book(String[] book) {
			this.title = book[0];
			this.author = book[1];
			this.genre = book[2];
			this.price = Double.parseDouble(book[3]);
			this.description = book[4];
		}
		
		public String toString() {
			return title + ": " + author; 
		}
	}

%>
<%
	String[][] books = {
		{"Moby Dick", "Herman Melville", "classic", "19.99", "Ishmael narrates the monomaniacal quest of Ahab, captain of the whaler Pequod, for revenge on the albino sperm whale Moby Dick"},
		{"Catcher In The Rye", "J. D. Salinger", "classic", "6.49", "The novel's protagonist Holden Caulfield has become an icon for teenage rebellion. The novel also deals with complex issues of identity, belonging, loss, connection, and alienation."},
		{"Ender's Game", "Orson Scott Card", "sci-fi", "8.20", "Ender's Game presents an imperiled mankind after two conflicts with the \"buggers\", an insectoid alien species. In preparation for an anticipated third invasion, children, including the novel's protagonist, Ender Wiggin, are trained from a very young age through increasingly difficult games including some in zero gravity, where Ender's tactical genius is revealed."},
		{"The Hobbit", "JRR Tolkien", "fantasy", "18.59", "The Hobbit follows the quest of home-loving hobbit Bilbo Baggins to win a share of the treasure guarded by the dragon, Smaug."}
	};
%>
