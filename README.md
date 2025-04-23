<header>

<!--
  <<< Author notes: Course header >>>
  Include a 1280×640 image, course title in sentence case, and a concise description in emphasis.
  In your repository settings: enable template repository, add your 1280×640 social image, auto delete head branches.
  Add your open source license, GitHub uses MIT license.
-->

# Personal Blog

This is my personal blog built with Hugo.

</header>

## Development

### Local Development with Docker

To run the blog locally using Docker:

```bash
docker-compose up
```

This will start a Hugo server at http://localhost:1313 with live reloading.

### Using Hugo Modules

This blog uses Hugo Modules for theme management. The theme is automatically downloaded when you build the site or run the server.

## Deployment

This blog is automatically deployed to GitHub Pages using the GitHub Actions workflow in `.github/workflows/hugo-deploy.yml`.

When changes are pushed to the main branch, the site is automatically built and deployed.

<footer>

<!--
  <<< Author notes: Footer >>>
  Add a link to get support, GitHub status page, code of conduct, license link.
-->

---

Get help: [Post in our discussion board](https://github.com/orgs/skills/discussions/categories/github-pages) &bull; [Review the GitHub status page](https://www.githubstatus.com/)

&copy; 2023 GitHub &bull; [Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md) &bull; [MIT License](https://gh.io/mit)

</footer>
