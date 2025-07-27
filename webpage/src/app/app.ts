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
  template: '<router-outlet></router-outlet>',
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App implements OnInit, OnDestroy {
  isDarkMode = signal(false);

  ngOnInit() {
    window.addEventListener('themeChange', this.handleThemeChange.bind(this));
    this.isDarkMode.set(document.body.classList.contains('dark-theme'));
  }

  ngOnDestroy() {
    window.removeEventListener('themeChange', this.handleThemeChange.bind(this));
  }

  private handleThemeChange = (event: CustomEvent< { isDark: boolean } >) => {
    this.isDarkMode.set(event.detail.isDark);
  }
}
