# Movie Review App
A simple app to store and review movies.
## Features

- **SQLite** used as the development database for quick setup and portability.
- **Devise** handles user authentication, registration, and session management.
- **Active Storage** supports uploading and displaying movie posters and user profile pictures.
- **TMDb API** integration to fetch movie details, posters, and metadata.  
  See: [TMDb Developer Docs](https://developer.themoviedb.org/docs/getting-started)
- **Admin Panel** with role-based access:
  - Manage users, movies, and reviews
  - Access restricted to admin accounts only
## How to Use

To get started, a user must first **sign in** or **sign up**.

**Sign In**  
<br>
<img src="https://github.com/user-attachments/assets/250acd9b-b52b-4e68-bcc6-0077e48a47ba" alt="sign_in" width="600">  
<br>

**Sign Up**  
<br>
<img src="https://github.com/user-attachments/assets/5175736c-fb06-4776-aa99-cb72436cb3ce" alt="sign_up" width="600">  
<br><br>

---

### 📝 Writing a Review

Once logged in, users can navigate to a movie and write, edit, or delete their own reviews.

**Before Writing a Review**  
<br>
<img src="https://github.com/user-attachments/assets/d2ab2478-51c6-41e5-af5f-a56a1ae87ee9" alt="before_review" width="600">  
<br>

**Writing a Review**  
<br>
<img src="https://github.com/user-attachments/assets/875d51c1-1fd9-4373-81f6-e0649ff6698d" alt="during_review" width="600">  
<br>

**After Submitting a Review**  
<br>
<img src="https://github.com/user-attachments/assets/6bb5ce00-591e-46a9-b220-f534d8914efd" alt="after_review" width="600">  
<br><br>

---

### 🎬 Browsing Movies

Users can explore available movies via the **Movies** page.

**Movie List**  
<br>
<img src="https://github.com/user-attachments/assets/302ee9f9-45e3-47ca-baae-96731daccb73" alt="movies_page" width="600">  
<br>

**Filtered by Genre**  
<br>
<img src="https://github.com/user-attachments/assets/6a3ba06f-6d56-436a-bd25-ffed6ab69d9c" alt="filtered_movies" width="600">  
<br><br>

---

### 👤 User Profile

Users can manage their reviews and update their profile pictures on their **profile page**.

**Before Profile Picture Change**  
<br>
<img src="https://github.com/user-attachments/assets/6d48cb27-741e-466a-aff2-51fb2238978a" alt="user_before" width="600">  
<br>

**After Profile Picture Change**  
<br>
<img src="https://github.com/user-attachments/assets/0b3882a6-17db-4ccc-8aa5-4fa984cea5a9" alt="user_after" width="600">  
<br><br>

---

### 🛠️ Admin Features (for admin users only)

Admins have access to a dedicated **Admin Panel** with several management tools.

**Admin Dashboard**  
<br>
<img src="https://github.com/user-attachments/assets/42727a61-4726-481a-ab94-f9702dcff1a0" alt="admin_panel" width="600">  
<br>

**Adding a Movie from TMDb**  
<br>
<img src="https://github.com/user-attachments/assets/04cb13fd-fea1-4968-9305-b96c9d089748" alt="moon_added" width="600">  
<br>

**Deleting a Movie**  
<br>
<img src="https://github.com/user-attachments/assets/ac4f6948-3a61-47fc-bcbc-9c25d27bf783" alt="moon_deleted" width="600">  
<br>

**Managing Reviews**  
<br>
<img src="https://github.com/user-attachments/assets/aa867c24-787f-4507-bd23-31156241e89e" alt="admin_reviews" width="600">  
<br>

**Managing Users**  
<br>
<img src="https://github.com/user-attachments/assets/8f2fc78a-c61a-4133-9cc5-ba68c35ecd7b" alt="admin_users" width="600"> 

## How to Run

This app uses Rails' encrypted credentials, which require a `config/master.key` to decrypt `config/credentials.yml.enc`.

- If you were given access to the project, make sure you have `config/master.key` in place.
- If you're starting fresh, you can generate a new one with:

  ```bash
  EDITOR="nano" bin/rails credentials:edit

**You will also need a TMDb API Key, it is free**  
Create an .env file with:
```.env
TMDB_API_KEY=your_tmdb_api_key_here
```  
---
### Using the Website
To use the app you will need to use one of the following accounts or create your own:  
  
**admin**  
Email: `admin@example.com`  
Password: `admin123`  
Admin: ✅  

**campbellesoup**  
Email: `campbellesoup@example.com`  
Password: `password123`  

**moviedave**  
Email: `moviedave@example.com`  
Password: `password123`  

**Cinema Or Not**  
Email: `cinemaornot@example.com`  
Password: `cinema@123` 
