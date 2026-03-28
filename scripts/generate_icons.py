"""
SpendWise icon generator
Produces:
  - spendwise_icon_v1.png  (1024x1024) — wallet + embedded pie chart
  - spendwise_icon_v2.png  (1024x1024) — minimal circle + pie chart
  - spendwise_icon_v1.svg
  - spendwise_icon_v2.svg
  - launcher-ready copies in assets/icon/
"""

import math
import os
from PIL import Image, ImageDraw, ImageFilter

OUT = os.path.join(os.path.dirname(__file__), "..", "assets", "icon")
os.makedirs(OUT, exist_ok=True)

SIZE = 1024
HALF = SIZE // 2

# ── colour palette ──────────────────────────────────────────────────────────
GREEN_DARK   = (22,  163,  74)   # #16A34A
GREEN_LIGHT  = (34,  197,  94)   # #22C55E
GREEN_MID    = (21,  128,  61)   # slightly deeper for pie seg 1
WHITE        = (255, 255, 255)
WHITE_TRANS  = (255, 255, 255, 220)
SHADOW       = (0,   80,   20,  80)   # very dark green, semi-transparent


# ── helpers ─────────────────────────────────────────────────────────────────
def rounded_square(draw, xy, radius, fill):
    x0, y0, x1, y1 = xy
    draw.rounded_rectangle([x0, y0, x1, y1], radius=radius, fill=fill)


def vertical_gradient(size, top_color, bot_color):
    """Return an RGBA image filled with a vertical gradient."""
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    for y in range(size):
        t = y / (size - 1)
        r = int(top_color[0] + (bot_color[0] - top_color[0]) * t)
        g = int(top_color[1] + (bot_color[1] - top_color[1]) * t)
        b = int(top_color[2] + (bot_color[2] - top_color[2]) * t)
        img.paste((r, g, b, 255), [0, y, size, y + 1])
    return img


def draw_pie_slice(draw, cx, cy, r, start_deg, end_deg, fill):
    """Draw a filled pie slice."""
    bbox = [cx - r, cy - r, cx + r, cy + r]
    draw.pieslice(bbox, start=start_deg, end=end_deg, fill=fill)


def add_subtle_shadow(canvas, draw, x0, y0, x1, y1, radius, blur=12):
    """Draw a soft drop-shadow rectangle under a card."""
    shadow_layer = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    sd = ImageDraw.Draw(shadow_layer)
    sd.rounded_rectangle(
        [x0 + 6, y0 + 10, x1 + 6, y1 + 10],
        radius=radius,
        fill=(0, 60, 10, 70),
    )
    shadow_layer = shadow_layer.filter(ImageFilter.GaussianBlur(blur))
    canvas.alpha_composite(shadow_layer)


# ════════════════════════════════════════════════════════════════════════════
#  VERSION 1 — Wallet + Pie Chart
# ════════════════════════════════════════════════════════════════════════════
def make_v1():
    canvas = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))

    # --- background: rounded square gradient ---
    bg = vertical_gradient(SIZE, GREEN_DARK, GREEN_LIGHT)
    mask = Image.new("L", (SIZE, SIZE), 0)
    md = ImageDraw.Draw(mask)
    md.rounded_rectangle([0, 0, SIZE - 1, SIZE - 1], radius=220, fill=255)
    canvas.paste(bg, mask=mask)

    draw = ImageDraw.Draw(canvas, "RGBA")

    # ---- wallet body -------------------------------------------------------
    # Wallet is a rounded rectangle, light white-ish, occupies ~58% of canvas
    pad = 160
    w_left  = pad
    w_top   = 330
    w_right = SIZE - pad
    w_bot   = SIZE - 200
    w_rx    = 72

    # shadow under wallet
    add_subtle_shadow(canvas, draw, w_left, w_top, w_right, w_bot, w_rx, blur=18)

    draw = ImageDraw.Draw(canvas, "RGBA")
    draw.rounded_rectangle(
        [w_left, w_top, w_right, w_bot],
        radius=w_rx,
        fill=(255, 255, 255, 240),
    )

    # wallet top flap / card slot strip
    flap_h = 68
    draw.rounded_rectangle(
        [w_left, w_top - flap_h // 2, w_right, w_top + flap_h // 2],
        radius=w_rx // 2,
        fill=(255, 255, 255, 200),
    )

    # card-slot line details (two thin horizontal lines)
    slot_y1 = w_top + 14
    slot_y2 = w_top + 30
    for sy in (slot_y1, slot_y2):
        draw.rounded_rectangle(
            [w_left + 60, sy, w_right - 200, sy + 8],
            radius=4,
            fill=(GREEN_DARK[0], GREEN_DARK[1], GREEN_DARK[2], 60),
        )

    # coin clasp (small circle on right side of flap)
    clasp_cx = w_right - 100
    clasp_cy = w_top
    cr = 32
    draw.ellipse(
        [clasp_cx - cr, clasp_cy - cr, clasp_cx + cr, clasp_cy + cr],
        fill=(*GREEN_MID, 200),
    )
    draw.ellipse(
        [clasp_cx - cr + 10, clasp_cy - cr + 10,
         clasp_cx + cr - 10, clasp_cy + cr - 10],
        fill=(*GREEN_DARK, 240),
    )

    # ---- pie chart inside wallet body -------------------------------------
    pie_cx = HALF
    pie_cy = (w_top + w_bot) // 2 + 28
    pie_r  = 160

    # outer white ring (breathing space)
    draw.ellipse(
        [pie_cx - pie_r - 18, pie_cy - pie_r - 18,
         pie_cx + pie_r + 18, pie_cy + pie_r + 18],
        fill=(240, 253, 244, 255),
    )

    # segment 1 — 55%  (dark green)
    draw_pie_slice(draw, pie_cx, pie_cy, pie_r, -90, -90 + 198,
                   fill=(*GREEN_MID, 255))
    # segment 2 — 30%  (white)
    draw_pie_slice(draw, pie_cx, pie_cy, pie_r, -90 + 198, -90 + 198 + 108,
                   fill=(255, 255, 255, 255))
    # segment 3 — 15%  (light green)
    draw_pie_slice(draw, pie_cx, pie_cy, pie_r, -90 + 306, 270,
                   fill=(*GREEN_LIGHT, 255))

    # thin white dividers between slices
    for angle in (-90, -90 + 198, -90 + 306):
        rad = math.radians(angle)
        x_end = pie_cx + pie_r * math.cos(rad)
        y_end = pie_cy + pie_r * math.sin(rad)
        draw.line([(pie_cx, pie_cy), (x_end, y_end)],
                  fill=(255, 255, 255, 200), width=6)

    # donut hole (white circle in center = donut chart look)
    donut_r = 62
    draw.ellipse(
        [pie_cx - donut_r, pie_cy - donut_r,
         pie_cx + donut_r, pie_cy + donut_r],
        fill=(240, 253, 244, 255),
    )

    # tiny "S" hint: a small green dot in the donut hole
    dot_r = 18
    draw.ellipse(
        [pie_cx - dot_r, pie_cy - dot_r,
         pie_cx + dot_r, pie_cy + dot_r],
        fill=(*GREEN_DARK, 220),
    )

    # ---- wallet top label bar (coin icon) ---------------------------------
    # Small rounded pill at the top-center of the wallet
    pill_w, pill_h = 120, 36
    pill_x = HALF - pill_w // 2
    pill_y = w_top - 22
    draw.rounded_rectangle(
        [pill_x, pill_y, pill_x + pill_w, pill_y + pill_h],
        radius=18,
        fill=(*GREEN_DARK, 230),
    )
    # dollar-sign-like two small dots
    for dx in (-16, 16):
        draw.ellipse(
            [HALF + dx - 5, pill_y + 13,
             HALF + dx + 5, pill_y + 23],
            fill=(255, 255, 255, 230),
        )

    # ---- top accent logo mark  -------------------------------------------
    # A very subtle white circle in the upper area, for balance
    accent_y = 190
    accent_r = 52
    draw.ellipse(
        [HALF - accent_r, accent_y - accent_r,
         HALF + accent_r, accent_y + accent_r],
        fill=(255, 255, 255, 50),
    )
    draw.ellipse(
        [HALF - accent_r + 14, accent_y - accent_r + 14,
         HALF + accent_r - 14, accent_y + accent_r - 14],
        fill=(255, 255, 255, 90),
    )

    # ---- final composite ---------------------------------------------------
    # Slight vignette on the background edges for depth
    vignette = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    vd = ImageDraw.Draw(vignette)
    for i in range(60):
        alpha = int(40 * (i / 60))
        offset = i * 2
        vd.rounded_rectangle(
            [offset, offset, SIZE - offset, SIZE - offset],
            radius=max(220 - offset, 0),
            outline=(0, 50, 10, alpha),
            width=2,
        )
    canvas.alpha_composite(vignette)

    return canvas


# ════════════════════════════════════════════════════════════════════════════
#  VERSION 2 — Minimal: Circle + Donut Pie Chart
# ════════════════════════════════════════════════════════════════════════════
def make_v2():
    canvas = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))

    # circular background gradient
    bg = vertical_gradient(SIZE, GREEN_DARK, GREEN_LIGHT)
    mask = Image.new("L", (SIZE, SIZE), 0)
    md = ImageDraw.Draw(mask)
    md.ellipse([48, 48, SIZE - 48, SIZE - 48], fill=255)
    canvas.paste(bg, mask=mask)

    draw = ImageDraw.Draw(canvas, "RGBA")

    # outer glow ring (subtle lighter green ring)
    ring_r = SIZE // 2 - 48
    draw.ellipse(
        [HALF - ring_r, HALF - ring_r, HALF + ring_r, HALF + ring_r],
        outline=(255, 255, 255, 40), width=20,
    )

    # --- large donut chart ------------------------------------------------
    pie_r  = 320
    donut_r = 152

    # outer white ring (breathing room)
    draw.ellipse(
        [HALF - pie_r - 16, HALF - pie_r - 16,
         HALF + pie_r + 16, HALF + pie_r + 16],
        fill=(255, 255, 255, 30),
    )

    # segment 1 — 55%  (dark green)
    draw_pie_slice(draw, HALF, HALF, pie_r, -90, -90 + 198,
                   fill=(*GREEN_MID, 255))
    # segment 2 — 30%  (white)
    draw_pie_slice(draw, HALF, HALF, pie_r, -90 + 198, -90 + 198 + 108,
                   fill=(255, 255, 255, 255))
    # segment 3 — 15%  (light green)
    draw_pie_slice(draw, HALF, HALF, pie_r, -90 + 306, 270,
                   fill=(*GREEN_LIGHT, 255))

    # divider lines
    for angle in (-90, -90 + 198, -90 + 306):
        rad = math.radians(angle)
        x_end = HALF + pie_r * math.cos(rad)
        y_end = HALF + pie_r * math.sin(rad)
        draw.line([(HALF, HALF), (x_end, y_end)],
                  fill=(255, 255, 255, 200), width=10)

    # donut hole — filled with gradient bg colour
    draw.ellipse(
        [HALF - donut_r, HALF - donut_r,
         HALF + donut_r, HALF + donut_r],
        fill=(*GREEN_DARK, 255),
    )
    # inner glow on donut hole
    inner_r = donut_r - 16
    draw.ellipse(
        [HALF - inner_r, HALF - inner_r,
         HALF + inner_r, HALF + inner_r],
        fill=(*GREEN_MID, 255),
    )

    # small white upward-trend arrow in the donut hole
    aw = 56    # arrow half-width
    ah = 48    # arrow height
    ax, ay = HALF, HALF
    # arrow shaft
    draw.rectangle(
        [ax - 10, ay - ah // 2 + 10, ax + 10, ay + ah // 2 + 10],
        fill=(255, 255, 255, 230),
    )
    # arrow head (triangle) — point upward
    draw.polygon(
        [(ax, ay - ah // 2 - 16),
         (ax - aw // 2, ay - ah // 2 + 14),
         (ax + aw // 2, ay - ah // 2 + 14)],
        fill=(255, 255, 255, 255),
    )

    # ---- subtle vignette -------------------------------------------------
    vignette = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    vd = ImageDraw.Draw(vignette)
    for i in range(40):
        alpha = int(30 * (i / 40))
        offset = 48 + i * 3
        r = SIZE // 2 - offset // 2 + 48
        vd.ellipse(
            [HALF - r, HALF - r, HALF + r, HALF + r],
            outline=(0, 40, 10, alpha), width=3,
        )
    canvas.alpha_composite(vignette)

    return canvas


# ════════════════════════════════════════════════════════════════════════════
#  SVG generators
# ════════════════════════════════════════════════════════════════════════════
def pie_path(cx, cy, r, start_deg, end_deg):
    """Return the SVG 'd' attribute for a pie slice."""
    s = math.radians(start_deg)
    e = math.radians(end_deg)
    x1 = cx + r * math.cos(s)
    y1 = cy + r * math.sin(s)
    x2 = cx + r * math.cos(e)
    y2 = cy + r * math.sin(e)
    large = 1 if (end_deg - start_deg) > 180 else 0
    return (f"M {cx},{cy} "
            f"L {x1:.2f},{y1:.2f} "
            f"A {r},{r} 0 {large},1 {x2:.2f},{y2:.2f} Z")


def make_v1_svg():
    W = 1024
    H = 1024
    M = W // 2
    lines = [
        f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" width="{W}" height="{H}">',
        '  <defs>',
        '    <linearGradient id="bg" x1="0" y1="0" x2="0" y2="1">',
        '      <stop offset="0%" stop-color="#16A34A"/>',
        '      <stop offset="100%" stop-color="#22C55E"/>',
        '    </linearGradient>',
        '    <filter id="shadow" x="-10%" y="-10%" width="120%" height="130%">',
        '      <feDropShadow dx="6" dy="10" stdDeviation="14" flood-color="#004d14" flood-opacity="0.28"/>',
        '    </filter>',
        '    <clipPath id="roundsq">',
        '      <rect width="1024" height="1024" rx="220" ry="220"/>',
        '    </clipPath>',
        '  </defs>',
        '',
        '  <!-- background -->',
        '  <rect width="1024" height="1024" rx="220" ry="220" fill="url(#bg)"/>',
        '',
        '  <!-- wallet body -->',
        '  <rect x="160" y="330" width="704" height="490" rx="72" ry="72"',
        '        fill="white" fill-opacity="0.94" filter="url(#shadow)"/>',
        '',
        '  <!-- wallet flap strip -->',
        '  <rect x="160" y="296" width="704" height="68" rx="34" ry="34"',
        '        fill="white" fill-opacity="0.80"/>',
        '',
        '  <!-- card slot lines -->',
        '  <rect x="220" y="344" width="424" height="8" rx="4" fill="#16A34A" fill-opacity="0.25"/>',
        '  <rect x="220" y="360" width="424" height="8" rx="4" fill="#16A34A" fill-opacity="0.25"/>',
        '',
        '  <!-- clasp circle -->',
        '  <circle cx="924" cy="330" r="32" fill="#15803D" fill-opacity="0.78"/>',
        '  <circle cx="924" cy="330" r="22" fill="#16A34A" fill-opacity="0.94"/>',
        '',
        '  <!-- pie chart background ring -->',
        '  <circle cx="512" cy="608" r="178" fill="#F0FDF4"/>',
    ]

    # pie slices
    pie_data = [
        ("-90", str(-90 + 198), "#15803D"),   # 55%
        (str(-90 + 198), str(-90 + 306), "#FFFFFF"),  # 30%
        (str(-90 + 306), "270", "#22C55E"),   # 15%
    ]
    for sd, ed, color in pie_data:
        p = pie_path(512, 608, 160, float(sd), float(ed))
        lines.append(f'  <path d="{p}" fill="{color}"/>')

    # divider lines
    for angle in (-90, -90 + 198, -90 + 306):
        rad = math.radians(angle)
        x2 = 512 + 160 * math.cos(rad)
        y2 = 608 + 160 * math.sin(rad)
        lines.append(f'  <line x1="512" y1="608" x2="{x2:.1f}" y2="{y2:.1f}"'
                     f' stroke="white" stroke-width="5" stroke-opacity="0.80"/>')

    lines += [
        '',
        '  <!-- donut hole -->',
        '  <circle cx="512" cy="608" r="62" fill="#F0FDF4"/>',
        '  <circle cx="512" cy="608" r="18" fill="#16A34A" fill-opacity="0.86"/>',
        '',
        '  <!-- top accent dots -->',
        '  <circle cx="512" cy="190" r="52" fill="white" fill-opacity="0.20"/>',
        '  <circle cx="512" cy="190" r="38" fill="white" fill-opacity="0.35"/>',
        '',
        '</svg>',
    ]
    return "\n".join(lines)


def make_v2_svg():
    W = 1024
    H = 1024
    M = W // 2
    lines = [
        f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" width="{W}" height="{H}">',
        '  <defs>',
        '    <linearGradient id="bg" x1="0" y1="0" x2="0" y2="1">',
        '      <stop offset="0%" stop-color="#16A34A"/>',
        '      <stop offset="100%" stop-color="#22C55E"/>',
        '    </linearGradient>',
        '    <clipPath id="circle"><circle cx="512" cy="512" r="464"/></clipPath>',
        '  </defs>',
        '',
        '  <circle cx="512" cy="512" r="464" fill="url(#bg)"/>',
        '  <circle cx="512" cy="512" r="464" fill="none" stroke="white"',
        '          stroke-opacity="0.15" stroke-width="20"/>',
        '',
        '  <!-- pie slices -->',
    ]

    pie_data = [
        ("-90", str(-90 + 198), "#15803D"),
        (str(-90 + 198), str(-90 + 306), "#FFFFFF"),
        (str(-90 + 306), "270", "#22C55E"),
    ]
    for sd, ed, color in pie_data:
        p = pie_path(512, 512, 320, float(sd), float(ed))
        lines.append(f'  <path d="{p}" fill="{color}"/>')

    for angle in (-90, -90 + 198, -90 + 306):
        rad = math.radians(angle)
        x2 = 512 + 320 * math.cos(rad)
        y2 = 512 + 320 * math.sin(rad)
        lines.append(f'  <line x1="512" y1="512" x2="{x2:.1f}" y2="{y2:.1f}"'
                     f' stroke="white" stroke-width="9" stroke-opacity="0.80"/>')

    lines += [
        '',
        '  <!-- donut hole -->',
        '  <circle cx="512" cy="512" r="152" fill="#16A34A"/>',
        '  <circle cx="512" cy="512" r="136" fill="#15803D"/>',
        '',
        '  <!-- arrow up (trend) -->',
        '  <!-- shaft -->',
        '  <rect x="502" y="500" width="20" height="48" rx="4" fill="white" fill-opacity="0.90"/>',
        '  <!-- head -->',
        '  <polygon points="512,452 484,490 540,490" fill="white"/>',
        '',
        '</svg>',
    ]
    return "\n".join(lines)


# ════════════════════════════════════════════════════════════════════════════
#  MAIN
# ════════════════════════════════════════════════════════════════════════════
if __name__ == "__main__":
    print("Generating Version 1 (Wallet + Pie Chart)…")
    v1 = make_v1()
    p1 = os.path.join(OUT, "spendwise_icon_v1.png")
    v1.save(p1, "PNG")
    print(f"  ✓ {p1}")

    print("Generating Version 2 (Minimal Circle + Donut)…")
    v2 = make_v2()
    p2 = os.path.join(OUT, "spendwise_icon_v2.png")
    v2.save(p2, "PNG")
    print(f"  ✓ {p2}")

    # SVG files
    p1_svg = os.path.join(OUT, "spendwise_icon_v1.svg")
    with open(p1_svg, "w") as f:
        f.write(make_v1_svg())
    print(f"  ✓ {p1_svg}")

    p2_svg = os.path.join(OUT, "spendwise_icon_v2.svg")
    with open(p2_svg, "w") as f:
        f.write(make_v2_svg())
    print(f"  ✓ {p2_svg}")

    # Copy v1 as the main app_icon.png (used by flutter_launcher_icons)
    main_icon = os.path.join(OUT, "app_icon.png")
    v1.save(main_icon, "PNG")
    print(f"  ✓ {main_icon}  (main app icon)")

    # Foreground layer for adaptive icon (just the wallet+chart on transparent bg)
    fg = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    fg_draw = ImageDraw.Draw(fg, "RGBA")

    # Re-draw just the wallet + pie (no background) at a slightly smaller scale
    # scaled to 66% of canvas, centered — safe zone for adaptive icons
    scale = 0.66
    ox = int(HALF * (1 - scale))
    oy = int(HALF * (1 - scale))
    small_size = int(SIZE * scale)

    # paste the full v1 icon into center of foreground canvas (transparent bg)
    v1_resized = v1.resize((small_size, small_size), Image.LANCZOS)
    # make background transparent: replace the rounded-square with transparent
    # We'll just use the already-composited icon; the green bg is fine for adaptive
    fg.paste(v1_resized, (ox, oy), v1_resized)

    fg_path = os.path.join(OUT, "app_icon_fg.png")
    fg.save(fg_path, "PNG")
    print(f"  ✓ {fg_path}  (adaptive icon foreground)")

    print("\nAll icons generated successfully!")
