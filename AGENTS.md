# AI Agent Guidelines

This repository manages a dendritic NixOS Flake configuration. Any AI agent or tooling interacting with this codebase MUST adhere strictly to the following guidelines:

1. **Strict Dependency & Packaging Rule:**
   - DO NOT use Flatpaks, AppImages, or Snap packages.
   - All applications MUST be installed natively via modular leaf wrappers under `modules/programs/`.
   - Use `nix-wrapper-modules` for all installed applications to encapsulate their binaries, flags, environment variables, and configurations.

2. **Namespace Guardrails:**
   - NEVER use deprecated namespaces (e.g., `sddm`, `services.xserver.desktopManager.plasma5`, `services.pulseaudio`).
   - For Desktop and Display Manager: Strictly use `services.desktopManager.plasma6` and `services.displayManager.plasma-login-manager`.
   - For Audio: Use `services.pipewire` (with PulseAudio emulation, but do not enable native PulseAudio).

3. **Secret Security:**
   - NEVER suggest or commit plaintext secrets (e.g., passwords, keys).
   - All secret files must end with the `.enc.yaml`, `.enc.json`, or `.enc.env` extension.
   - Secrets must be encrypted using `sops` and managed via `sops-nix`.

4. **Multi-Host Parity:**
   - Keep system-wide modules generic and reusable. Place them under `modules/core/`.
   - Push host-specific overrides (like hardware configurations, disk IDs) strictly to their respective folders in `hosts/<hostname>/`.
