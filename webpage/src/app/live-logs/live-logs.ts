import { CommonModule } from '@angular/common';
import { Component, ViewChild, ElementRef } from '@angular/core';
import { RouterModule } from '@angular/router';

@Component({
  standalone: true,
  selector: 'app-live-logs',
  imports: [CommonModule, RouterModule],
  templateUrl: './live-logs.html',
})

export class LiveLogs {
  logs: string[] = [];
  private intervalId: any;

  // log container for autoscrolling
  @ViewChild('logContainer') logContainer!: ElementRef<HTMLDivElement>;

  private readonly minInterval = 1000;
  private readonly maxInterval = 1500;
  intervalTime = Math.floor(Math.random() * (this.maxInterval - this.minInterval + 1)) + this.minInterval;

  // start the automatic log generation
  ngOnInit() {
    this.intervalId = setInterval(() => {
      const newLog = `[${new Date().toLocaleDateString()}] Event: ${this.randomEvent()}`;
      this.logs.push(newLog);
      setTimeout(() => this.scrollToBottom(), 0);
    }, this.intervalTime);
  }

  // autoscroll
  scrollToBottom(): void {
    if (this.logContainer) {
      const el = this.logContainer.nativeElement;
      el.scrollTop = el.scrollHeight;
    }
  }

  // Random event getter
  private randomEvent(): string {
    const events = [
      'User logged in',
      'User logged out',
      'File uploaded',
      'File downloaded',
      'Warning issued',
      'Data processed',
      'Connection established',
      'Error: Connection lost',
      'System started',
      'System stopped',
      'Auth token refreshed',
      'New message received',
      'User profile updated',
    ];
    return events[Math.floor(Math.random() * events.length)];
  }
}
