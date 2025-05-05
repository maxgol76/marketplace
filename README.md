# Laravel Marketplace Project

This is a Laravel 11-based marketplace application built with Docker and PostgreSQL. It features a modern authentication system via Jetstream (Livewire), supports role-based user management (Administrator, Seller, Buyer), and uses Vite for frontend asset compilation.

---

## 🚀 Features

- Laravel 11 + Jetstream (Livewire)
- User registration, login, password reset
- Email verification
- Role-based access control (using Spatie Laravel-Permission)
- PostgreSQL database
- Dockerized development environment
- Vite + Tailwind CSS for frontend
- Xdebug integration
- Makefile for easy Docker commands

---

## 🧰 Requirements

- Docker Desktop
- Node.js (18+) & npm (locally or in Docker)
- Composer
- Git

---

## ⚙️ Setup Instructions

### 1. Clone the Repository

```bash
git clone <your-repo-url> marketplace
cd marketplace
```

### 2. Copy the Environment File

```bash
cp .env.example .env
```

### 3. Start Docker Containers

```bash
docker-compose up -d --build
```

### 4. Install PHP Dependencies

```bash
docker exec -it app composer install
```

### 5. Generate Application Key

```bash
docker exec -it app php artisan key:generate
```

### 6. Run Migrations

```bash
docker exec -it app php artisan migrate
```

### 7. Install Frontend Dependencies

On host (if Node.js installed locally):

```bash
npm install
npm run dev
```

Or inside container:

```bash
docker exec -it node sh
npm install
npm run dev
```

---

## 👥 User Roles

This app supports three user roles (using Spatie Laravel-Permission):

- `Administrator` – full access
- `Seller` – can manage listings/products
- `Buyer` – can browse and purchase

To assign roles:

```php
$user->assignRole('admin');
```

To protect routes:

```php
Route::middleware(['role:admin'])->group(function () {
    // Admin routes
});
```

---

## 🐳 Docker Commands via Makefile

```bash
make up        # docker-compose up -d --build
make down      # docker-compose down
make bash      # enter app container
make logs      # view container logs
```

---

## 🧠 Troubleshooting

- **CSS not loading?**
  - Make sure `npm run dev` is running
  - Check Vite port and update `APP_URL` in `.env` (e.g. `http://127.0.0.1:5173`)

- **Permissions error (laravel.log)?**
  - Fix with:
    ```bash
    chmod -R 775 storage bootstrap/cache
    chown -R www-data:www-data storage bootstrap/cache
    ```

- **PostgreSQL not connecting?**
  - Verify `DB_HOST`, `DB_PORT`, `DB_USERNAME`, and `DB_PASSWORD` match `docker-compose.yml`

---

## 📁 Project Structure

```
├── app/
├── bootstrap/
├── config/
├── database/
│   ├── migrations/
│   └── seeders/
├── docker/
├── public/
├── resources/
│   ├── css/
│   ├── js/
│   └── views/
├── routes/
├── storage/
├── tests/
├── .env
├── Dockerfile
├── docker-compose.yml
└── vite.config.js
```

---

## 📜 License

This project is open-source and licensed under the [MIT license](https://opensource.org/licenses/MIT).


---

## 🌱 Database Seeding

To populate your database with sample data, you can use Laravel seeders.

1. Create a seeder:
```bash
php artisan make:seeder UserSeeder
```

2. Define dummy users or roles in `database/seeders/UserSeeder.php`:
```php
use App\Models\User;
use Spatie\Permission\Models\Role;

public function run()
{
    $adminRole = Role::firstOrCreate(['name' => 'Administrator']);

    $user = User::create([
        'name' => 'Admin User',
        'email' => 'admin@example.com',
        'password' => bcrypt('password'),
    ]);

    $user->assignRole($adminRole);
}
```

3. Run seeders:
```bash
php artisan db:seed --class=UserSeeder
```

---

## 🚀 Deployment Tips

- Set `APP_ENV=production` and `APP_DEBUG=false` in your `.env` file.
- Build frontend assets:
```bash
npm run build
```
- Set correct permissions:
```bash
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
```
- Run optimizations:
```bash
php artisan config:cache
php artisan route:cache
php artisan view:cache
```
- Use a process manager like **Supervisor** or **systemd** to run `php artisan queue:work` in production (if using queues).

---

## ✅ Testing

Laravel includes PHPUnit for automated testing.

Run all tests:
```bash
php artisan test
```

Create a test:
```bash
php artisan make:test ExampleTest
```

Test files are located in the `tests/Feature` and `tests/Unit` directories.
