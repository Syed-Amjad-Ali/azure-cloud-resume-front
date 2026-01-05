
## Project Background and Motivation

I wanted to build a personal portfolio website where I could showcase my data projects and actually use it in real life, not just as a demo. At the same time, I wanted to properly learn cloud computing by building and operating a real system instead of stopping at theory or isolated examples.

While researching practical Azure projects, I came across the **[Cloud Resume Challenge (Azure edition)](https://cloudresumechallenge.dev/docs/the-challenge/azure/)**. It is a well-known community challenge that describes what a cloud-native resume website should look like in production, including static hosting, serverless backends, databases, infrastructure as code, and CI/CD. I did not treat it as a checklist to rush through. Instead, I used it as a design reference and spent time understanding why each component exists and how Azure’s managed services fit together in a real deployment workflow.

I was also inspired by cloud practitioners who focus on learning by building, including content by **[Gwyneth Peña-Siguenza (GPSlearnsAI)](https://www.linkedin.com/in/madebygps/)**. Her Azure-focused projects reinforced the idea that platform fundamentals are best learned by working with real systems rather than toy examples.

I chose Azure deliberately because, based on my research, many Norwegian companies rely heavily on Azure rather than AWS or GCP. Since I plan to work in the Norwegian market, I wanted my cloud experience to be directly relevant.

This project also played a big role in helping me prepare for and pass the AZ-104 Azure Administrator certification, because I was working hands-on with core Azure services throughout the process.

## Domain Choice and Early Lessons

Since this website is something I plan to use long term, I decided to use a custom domain and chose a .no domain because I intend to work in Norway.

Connecting a custom domain forced me to properly understand topics such as DNS configuration, the practical difference between HTTP and HTTPS, TLS certificates, and how CDN caching and cache invalidation actually behave in production. These are topics that are easy to gloss over in theory but become very concrete once you set them up yourself and break them a few times.

## What I Built and Focused On

Once the basic website was live, I focused on two main areas.

The first was the UI and UX of the website. I am not a frontend developer, and this was one of the more challenging parts of the project. I used ChatGPT to help generate simple HTML and CSS, but I quickly realized that UI and UX depend heavily on visual judgment and comfort rather than pure logic. This meant a lot of manual tweaking, trial and error, and staring at the screen to see what felt right. After some struggle, I am genuinely happy with how the site looks and feels, even though it is intentionally simple.

The second focus area was the visitor counter. I wanted a counter that increases every time the page is refreshed. This required wiring together a JavaScript frontend, an HTTP-triggered Azure Function, and Cosmos DB to persist the visit count. Along the way, I had to deal with CORS configuration, environment variables, and making sure the function API was not exposed carelessly. This part was challenging but very rewarding, because it felt like building a real backend service rather than a mock example.

## CI/CD and Automation

After everything was working manually, I decided to push the project further by setting up a proper CI/CD pipeline.

I implemented a GitHub Actions workflow that authenticates to Azure using OpenID Connect, uploads the frontend files to Azure Blob Storage, and purges the CDN cache automatically. There are no client secrets or keys stored in the repository. From that point on, updating the website became very smooth. I can make changes locally in VS Code, push them to GitHub, and the website updates automatically with the CDN cache refreshed.

This step made the project feel much closer to a real production system and removed a lot of manual friction from development.

## Why This Project Matters to Me

This project reflects how I like to learn and work with cloud and data platforms. I prefer understanding system boundaries instead of just writing code, using managed services where they make sense, and focusing on security and automation from the beginning. Most importantly, this project was genuinely fun to build, and it is something I actively maintain and improve.

It is not just a demo. It is a small but complete cloud system that I actually use.

## Links

Live website: https://syedamjadali.no  
Frontend repository: this repository  
Backend using Azure Functions and Cosmos DB will be linked once CI/CD is completed

## To Do

1) Add CI/CD for the backend Azure Functions and Cosmos DB components  
2) Make the entire setup deployable using infrastructure as code, such as ARM or Bicep templates, so the full system can be provisioned automatically

