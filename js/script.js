window.addEventListener("DOMContentLoaded", (event) => {
  // Get the last known count from localStorage (default to "Loading..." if not found)
  let lastCount = localStorage.getItem("visitCount") || "Loading...";
  document.getElementById("visitor-count").innerText = `Visitor Count: ${lastCount}`;

  // Fetch the latest count from the Azure Function
  getVisitCount();
});

const functionApi = "https://amjad-portfolio-counter-dbbfb2exdvbzfzgm.westeurope-01.azurewebsites.net/api/plus-one";



const getVisitCount = () => {
  fetch(functionApi)
    .then((response) => response.text()) // Fetch response as plain text
    .then((data) => {
      console.log("Raw response from API:", data);
      const countMatch = data.match(/\d+/);
      const count = countMatch ? parseInt(countMatch[0], 10) : 0;
      console.log("Extracted count:", count);

      // Update the HTML element
      document.getElementById("visitor-count").innerText = `and this page has been viewed ${count} times :)`;

      // Store the latest count in localStorage
      localStorage.setItem("visitCount", count);
    })
    .catch((error) => {
      console.error("Error occurred:", error);
      document.getElementById("visitor-count").innerText = "Visitor count unavailable.";
    });
};




// Filter Projects by Category
// Filter Projects by Category
document.addEventListener("DOMContentLoaded", function () {
    const filterButtons = document.querySelectorAll(".filter-button");
    const portfolioCards = document.querySelectorAll(".portfolio-card");

    filterButtons.forEach(button => {
        button.addEventListener("click", function () {
            const category = this.getAttribute("data-filter");

            // Remove "active" class from all buttons
            filterButtons.forEach(btn => btn.classList.remove("active"));
            // Add "active" class to clicked button
            this.classList.add("active");

            // Show or hide projects based on the selected category
            portfolioCards.forEach(card => {
                const cardCategories = card.getAttribute("data-category");
                if (category === "all" || cardCategories.includes(category)) {
                    card.style.display = "block"; // Show matching projects
                } else {
                    card.style.display = "none"; // Hide non-matching projects
                }
            });
        });
    });
});


// Toggle Content Visibility
function toggleContent(id) {
    var content = document.getElementById(id);
    if (content.style.display === "none" || content.style.display === "") {
        content.style.display = "block";
    } else {
        content.style.display = "none";
    }
}

document.querySelector(".contact-form").addEventListener("submit", async (e) => {
    e.preventDefault(); // Prevent form default submission behavior

    const formData = {
        name: document.getElementById("name").value,
        email: document.getElementById("email").value,
        message: document.getElementById("message").value,
    };

    try {
        // Send data to Azure Function
        const response = await fetch("https://amjadcontactbackend.azurewebsites.net/api/httpTrigger1", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(formData),
        });

        if (response.ok) {
            // Show success alert
            alert("Thank you for your message! We'll get back to you soon.");
            // Reset form
            document.querySelector(".contact-form").reset();
        } else {
            // Show error alert
            alert("Something went wrong. Please try again.");
        }
    } catch (error) {
        console.error("Error sending form data:", error);
        alert("An unexpected error occurred. Please try again.");
    }
});


// Toggle Content Visibility
function toggleContent(id) {
    var content = document.getElementById(id);
    if (content.style.display === "none" || content.style.display === "") {
        content.style.display = "block";
    } else {
        content.style.display = "none";
    }
}
function toggleReadMore(id) {
    var content = document.getElementById(id);
    content.style.display = content.style.display === "none" || content.style.display === "" ? "block" : "none";
}

