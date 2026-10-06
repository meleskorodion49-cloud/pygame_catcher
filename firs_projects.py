import random as rd
import sys
import pygame  # type: ignore

pygame.init()

# 1. Выносим настройки в понятные константы
SCREEN_WIDTH = 1024
SCREEN_HEIGHT = 620
FPS = 100
PLATFORM_SPEED = 5
DIAMOND_SPEED = 3

screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("Diamond Catcher")
clock = pygame.time.Clock()

# Загрузка картинок
diamond_img = pygame.image.load("images/diamond.png")
platform_img = pygame.image.load("images/images.png")

# Размеры объектов, чтобы не угадывать цифры в коде
DIAMOND_WIDTH = diamond_img.get_width()
DIAMOND_HEIGHT = diamond_img.get_height()
PLATFORM_WIDTH = platform_img.get_width()
PLATFORM_HEIGHT = platform_img.get_height()

# Начальные координаты платформы
x_platform = (SCREEN_WIDTH - PLATFORM_WIDTH) // 2
y_platform = SCREEN_HEIGHT - PLATFORM_HEIGHT

active_diamonds = []  # Список для падающих алмазов
run = True

# 2. Главный игровой цикл
while run:
    screen.fill((255, 255, 255))
    screen.blit(platform_img, (x_platform, y_platform))

    # Шанс появления нового алмаза
    if rd.randrange(100) < 1:
        x_diamond = rd.randrange(0, SCREEN_WIDTH - DIAMOND_WIDTH, 10)
        y_diamond = 0
        # Сохраняем алмаз как понятный словарь, а не список с индексами
        active_diamonds.append({"x": x_diamond, "y": y_diamond})

    # Обновление и отрисовка алмазов
    for diamond in active_diamonds[:]:  # Срез [:] для безопасного удаления из списка
        diamond["y"] += DIAMOND_SPEED

        # Проверка столкновения (границы платформы)
        hit_x = (
            diamond["x"] + DIAMOND_WIDTH > x_platform
            and diamond["x"] < x_platform + PLATFORM_WIDTH
        )
        hit_y = diamond["y"] + DIAMOND_HEIGHT >= y_platform

        if hit_x and hit_y:
            active_diamonds.remove(diamond)  # Алмаз пойман
        elif diamond["y"] > SCREEN_HEIGHT:
            active_diamonds.remove(diamond)  # Алмаз улетел за экран
        else:
            screen.blit(diamond_img, (diamond["x"], diamond["y"]))

    # Управление платформой
    keys = pygame.key.get_pressed()
    if keys[pygame.K_RIGHT] and ((x_platform + PLATFORM_WIDTH) < SCREEN_WIDTH):
        x_platform += PLATFORM_SPEED
    elif keys[pygame.K_LEFT] and x_platform > 0:
        x_platform -= PLATFORM_SPEED

    # Проверка выхода из игры
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            run = False

    clock.tick(FPS)
    pygame.display.flip()

pygame.quit()
sys.exit()
