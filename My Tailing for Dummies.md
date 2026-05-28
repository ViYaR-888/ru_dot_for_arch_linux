# MyTailing for Dummies

So you installed my rice, stared at the pretty screen for five minutes, and now you're wondering: *"How the hell do I actually move my windows around?"*

Relax. You're not dumb. Tiling window managers just have a learning curve shaped like a brick wall. But once you get these keybinds into your muscle memory, you'll be throwing windows around faster than you can say *"i3 is overrated"*.

This guide covers **only** the window management stuff. If you're looking for how to open Firefox, you're beyond saving. (It's `Super + F`. There, I saved you anyway.)

---

## The Philosophy

In a normal desktop (Windows, GNOME, KDE), windows are like papers scattered on a messy desk. You drag them, overlap them, and lose them behind each other like your dignity after a bad Tinder date.

In Hyprland, windows **tile**. They automatically arrange themselves into a neat grid. No overlap. No dragging. No "where the f*** did my terminal go" moments.

Your job isn't to *place* windows. Your job is to *organize* them. Move focus. Swap positions. Bump them to another workspace. That's it.

Now shut up and learn the keybinds.

---

## The Golden Rule

`Super` is your **Windows key** (or Command key if you're one of those people). Every window command starts with it. Remember this, or the next five minutes will be very confusing.

---

## Moving Focus

Before you can do anything with a window, you need to **focus** it. Think of it as the tiling equivalent of clicking on a window, except your mouse is now gathering dust.

| Keybind | What It Does |
|---|---|
| `Super + h` | Focus the window to the **left** |
| `Super + j` | Focus the window **below** |
| `Super + k` | Focus the window **above** |
| `Super + l` | Focus the window to the **right** |

**Pro tip:** Press these rapidly like you're playing a rhythm game. If text starts appearing in your terminal, you're letting go of `Super` too early. Hold it like you're clinging to a cliff edge.

---

## Swapping Windows

Sometimes a window is in the wrong spot. Don't close it. Don't drag it with your filthy mouse. Just **swap** it.

| Keybind | What It Does |
|---|---|
| `Super + Shift + h` | Swap focused window with the one on the **left** |
| `Super + Shift + j` | Swap focused window with the one **below** |
| `Super + Shift + k` | Swap focused window with the one **above** |
| `Super + Shift + l` | Swap focused window with the one on the **right** |

**Test this now:** Open two terminals side by side. Swap them back and forth like a confused air traffic controller. Feel the power.

---

## Resizing Windows

Resizing in a tiler requires entering a special mode. This is because normal keybinds would clash with everything else, and Hyprland doesn't trust you with direct resize keys.

1. **Enter Resize Mode:** `Super + X`
   - You'll see a notification: *"Resize mode: hjkl: resize | Esc: exit"*
   - While in this mode, **every other key on your keyboard is blocked**. You cannot type. You cannot switch windows. You are in Resize Jail until you escape.

2. **Do the resizing:**

| Key | What It Does |
|---|---|
| `h` | Shrink from the **left** (or grow leftward, depends on your layout, just press it) |
| `l` | Expand to the **right** |
| `k` | Shrink from the **top** |
| `j` | Expand **downward** |

3. **Get out:** Press `Escape`
   - You'll see: *"Resize mode: Exited"*
   - Your keyboard works again. Congratulations, you're free.

**Why the notification?** Because you **will** forget you're in resize mode, try to type something, and stare at the screen wondering why nothing is happening. The notification is your "hey dummy, press Esc" reminder.

---

## Workspaces 

| Keybind | What It Does |
|---|---|
| `Super + Alt + Right` | Go to the **next** workspace (creates a new empty one if it doesn't exist) |
| `Super + Alt + Left` | Go to the **previous** workspace |
| `Super + Shift + Alt + Right` | Take the focused window and **move it** to the next workspace, then follow it there |
| `Super + Shift + Alt + Left` | Same thing, but to the previous workspace |

**The GNOME refugee special:** These keybinds are intentionally similar to GNOME's `Super+Alt+Arrow` shortcuts. If you migrated from there, your fingers already know this. You're welcome.

**Pro workflow:** Put your browser on workspace 1, your code editor on workspace 2, and your terminal on workspace 3. Then fly between them like a keyboard-powered god.

---

## Wait, I Can Still Use The Mouse?


| Mouse Action | What It Does |
|---|---|
| `Super + Left Click Drag` | Move a window (even in tiling mode, it becomes floating temporarily) |
| `Super + Right Click Drag` | Resize a window |

But honestly, if you're using the mouse for window management, what are we even doing here?

---

## Your First Two Minutes (Test Drive)

1. Open a terminal: `Super + Space`
2. Open another terminal: `Super + Space` again
3. Move focus left/right: `Super + h`, `Super + l`
4. Swap them: `Super + Shift + l`
5. Enter resize mode: `Super + X`. Make one terminal **chonky** with `l`. Exit with `Esc`.
6. Move one terminal to a new workspace: `Super + Shift + Alt + Right`. Watch it slide away smoothly.
7. Go back: `Super + Alt + Left`. There it is.

You just learned 80% of tiling window management. The other 20% is screaming at window rules that don't work.

---

## Oh God it's not working!

- **Resize mode won't let me type:** Yes. That's the point. Press `Escape`.
- **Workspace shortcuts do nothing:** Are you holding `Alt`? `Super+Shift+Alt`, not just `Super+Shift`. Count your modifiers.
- **Everything is slow and laggy:** Check if the animations section exists in the config. If it's missing, something ate it. Re-copy from the main dotfiles.
- **The terminal is kitty and it crashes:** You're on a virtual machine, aren't you? Read the main README. Switch to `foot`.

---

## Graduation

You now know enough to pretend you're an advanced Linux user on Reddit. Go forth, open fifty terminal windows, arrange them perfectly, take a screenshot for r/unixporn, and then close them all because you didn't actually have anything to do.
