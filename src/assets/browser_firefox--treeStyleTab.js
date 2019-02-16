{"configsVersion":2,"notifiedFeaturesVersion":3,"style":"vertigo","maxTreeLevel":1,"scrollbarMode":2,"lastConfirmedToCloseTabs":1540429149800,"sidebarScrollbarPosition":0,"optionsExpandedSections":["section-advanced"],"userStyleRules":"/* move add tab button to top */\n.newtab-button-box {\n\tposition: fixed;\n\ttop: 0;\n\tleft: 0;\n\tright: 0;\n}\n\n.newtab-button {\n\theight: 24px;\n}\n\n.newtab-button::before {\n\tvertical-align: middle;\n}\n\n#tabbar {\n\ttop: 24px !important;\n\tbottom: 0 !important;\n}\n\n.tab.pinned {\n\tmargin-top: 24px;\n}\n\n/* avoid close animation bugs */\n.tab {\n\ttransform: translateZ(0) scale(1.0, 1.0);\n}\n\n/* avoid blurry icons */\n.favicon {\n\tbackface-visibility: hidden;\n\ttransform: translateZ(0) scale(1.0, 1.0);\n}\n\n/* pinned sites with bigger favicon */\n:root {\n\t--faviconized-tab-size: 59px;\n\t--faviconized-tab-size-script: calc(var(--faviconized-tab-size) / 1.74);\n}\n\n#dummy-favicon-size-box {\n\tmin-height: var(--faviconized-tab-size-script);\n\tmax-height: var(--faviconized-tab-size-script);\n}\n\n.tab.pinned {\n\t--favicon-size: 48px;\n\twidth: 60px;\n}\n\n.tab.pinned:nth-of-type(2) {\n\tleft: 60px !important;\n}\n\n.tab.pinned:nth-of-type(3) {\n\tleft: 120px !important;\n}\n\n.tab.pinned:nth-of-type(4) {\n\tleft: 180px !important;\n}\n\n.tab:not(.pinned) {\n\t--favicon-size: 16px;\n}\n\n/* pinned sites favicon centered */\n.tab.pinned .favicon {\n\tdisplay: flex;\n\tjustify-content: center;\n\talign-items: center;\n}\n\n/* remove space to the left of tabs */\n.tab:not(.pinned) {\n\tpadding-left: 0px !important;\n}\n\n/* close button visible only on hover */\n.tab .closebox {\n\ttransition: .5s ease-out opacity;\n\tvisibility: collapse;\n\topacity: 0;\n}\n\n.tab:hover .closebox,\n.closebox:hover {\n\tvisibility: visible;\n\topacity: .5;\n}\n\n/* remove sound icon on pinned sites */\n.tab.pinned .sound-button {\n\tdisplay: none !important;\n}\n\n/* remove favicon indicators */\n.favicon::before {\n\tdisplay: none !important;\n}\n\n/* shadow on extremes to indicate scroll */\n#tabbar {\n\toverflow: auto;\n\tmax-height: 100%;\n\tmargin-left:0 !important;\n\tmargin-right:0 !important;\n\tscrollbar-width: none;\n\tbackground:\n\t\t/* Shadow covers */\n\t\tlinear-gradient(#f0f0f0 30%, rgba(255,255,255,0)),\n\t\tlinear-gradient(rgba(255,255,255,0), #f0f0f0 70%) 0 100%,\n\t\t\n\t\t/* Shadows */\n\t\tradial-gradient(farthest-side at 50% 0, rgba(0,0,0,.2), rgba(0,0,0,0)),\n\t\tradial-gradient(farthest-side at 50% 100%, rgba(0,0,0,.2), rgba(0,0,0,0)) 0 100%;\n\tbackground-color: #f0f0f0;\n\tbackground-repeat: no-repeat;\n\tbackground-size: 100% 40px, 100% 40px, 100% 14px, 100% 14px;\n\t/* Opera doesn't support this in the shorthand */\n\tbackground-attachment: local, local, scroll, scroll;\n}\n","sidebarPosition":1,"sidebarDirection":1,"faviconizePinnedTabs":true,"showCollapsedDescendantsByTooltip":true,"context_closeDescendants":true,"context_bookmarkTree":false,"context_expandAll":false,"context_collapseAll":false,"showContextualIdentitiesSelector":false,"showNewTabActionSelector":true,"autoCollapseExpandSubtreeOnAttach":false,"autoCollapseExpandSubtreeOnSelect":false,"autoCollapseExpandSubtreeOnSelectExceptCurrentTabRemove":false,"collapseExpandSubtreeByDblClick":true,"dropLinksOnTabBehavior":2,"simulateCloseTabByDblclick":false,"optionsExpandedGroups":["group-allConfigs"],"debug":false,"applyThemeColorToIcon":false,"useCachedTree":false,"autoAttachSameSiteOrphan":1,"showTabDragHandle":false,"colorScheme":"system-color","supportTabsMultiselect":true,"parentTabBehaviorForChanges":0,"autoExpandIntelligently":false,"simulateSVGContextFill":false}