import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { marked } from 'marked';
import { RouterModule } from '@angular/router';

@Component({
  standalone: true,
  selector: 'app-knowledge-editor',
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './knowledge-editor.html',
  // styleUrl: './knowledge-editor.css'
})
export class KnowledgeEditor {
  content: string = '';
  previewMode: boolean = false;

  // helper for preview button
  togglePreview(): void {
    this.previewMode = !this.previewMode;
  }

  // save popup (when testing on webpage)
  save(): void {
    console.log('Content saved:', this.content);
    alert('Content saved successfully!');
  }

  // get rendered markdown
  get renderedMarkdown(): string {
    const result = marked(this.content);
    if (result instanceof Promise) {
      console.warn('Marked returned a promise, which is unexpected in this context.');
      return '';
    }
    return result;
  }
}
