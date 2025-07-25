import { ComponentFixture, TestBed } from '@angular/core/testing';

import { KnowledgeEditor } from './knowledge-editor';

describe('KnowledgeEditor', () => {
  let component: KnowledgeEditor;
  let fixture: ComponentFixture<KnowledgeEditor>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [KnowledgeEditor]
    })
    .compileComponents();

    fixture = TestBed.createComponent(KnowledgeEditor);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
