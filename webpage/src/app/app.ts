import { Component, signal, OnInit, OnDestroy } from '@angular/core';
import { RouterOutlet, RouterModule } from '@angular/router';

declare global {
  interface WindowEventMap {
    'themeChange': CustomEvent<{ isDark: boolean }>;
  }
}

@Component({
  standalone: true,
  selector: 'app-root',
  imports: [RouterOutlet, RouterModule],
  template: `
    <div [style.opacity]="isReady() ? 1 : 0" [style.transition]="'opacity 0.3s ease'">
      <router-outlet></router-outlet>
    </div>
  `,
  styleUrl: './app.css'
})
export class App implements OnInit, OnDestroy {
  isDarkMode = signal(false);
  isReady = signal(false);

  ngOnInit() {
    // Listen for theme changes
    window.addEventListener('themeChange', this.handleThemeChange.bind(this));
    this.isDarkMode.set(document.body.classList.contains('dark-theme'));
    
    // Simulate delay to allow dashboard to load
    setTimeout(() => {
      this.isReady.set(true);
    }, 250);
  }

  ngOnDestroy() {
    window.removeEventListener('themeChange', this.handleThemeChange.bind(this));
  }

  private handleThemeChange = (event: CustomEvent< { isDark: boolean } >) => {
    this.isDarkMode.set(event.detail.isDark);
  }
}