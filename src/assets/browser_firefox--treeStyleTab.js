{
	"configsVersion": 1,
	"notifiedFeaturesVersion": 3,
	"style": "vertigo",
	"maxTreeLevel": -1,
	"scrollbarMode": 2,
	"lastConfirmedToCloseTabs": 1540429149800,
	"sidebarScrollbarPosition": 0,
	"optionsExpandedSections": [
		"section-appearance",
		"section-advanced",
		"section-contextMenu",
		"section-newTab",
		"section-treeBehavior",
		"section-drag",
		"section-shortcuts"
	],
	"userStyleRules": "/* move add tab button to top */\n.newtab-button-box {\n\tposition: fixed;\n\ttop: 0;\n\tleft: 0;\n\tright: 0;\n\theight: 24px;\n}\n\n.newtab-button::before {\n\tpadding: 4px 0;\n}\n\n#tabbar {\n\ttop: 24px !important;\n\tbottom: 0 !important;\n}\n\n.tab.pinned {\n\tmargin-top: 24px;\n}\n\n\n/* close button visible only on hover */\n.tab .closebox {\n\ttransition: .5s ease-out opacity;\n\tvisibility: collapse;\n\topacity: 0;\n}\n\n.tab:hover .closebox {\n\tvisibility: visible;\n\topacity: .5;\n}\n\n/* shadow on extremes to indicate scroll */\n#tabbar {\n\toverflow: auto;\n\tmax-height: 100%;\n\tbackground:\n\t\t/* Shadow covers */\n\t\tlinear-gradient(#f0f0f0 30%, rgba(255,255,255,0)),\n\t\tlinear-gradient(rgba(255,255,255,0), #f0f0f0 70%) 0 100%,\n\t\t\n\t\t/* Shadows */\n\t\tradial-gradient(farthest-side at 50% 0, rgba(0,0,0,.2), rgba(0,0,0,0)),\n\t\tradial-gradient(farthest-side at 50% 100%, rgba(0,0,0,.2), rgba(0,0,0,0)) 0 100%;\n\tbackground-color: #f0f0f0;\n\tbackground-repeat: no-repeat;\n\tbackground-size: 100% 40px, 100% 40px, 100% 14px, 100% 14px;\n\t/* Opera doesn't support this in the shorthand */\n\tbackground-attachment: local, local, scroll, scroll;\n}",
	"sidebarPosition": 1,
	"sidebarDirection": 1,
	"faviconizePinnedTabs": true,
	"showCollapsedDescendantsByTooltip": true,
	"context_closeDescendants": true,
	"context_bookmarkTree": false,
	"context_expandAll": false,
	"context_collapseAll": false,
	"showContextualIdentitiesSelector": false,
	"showNewTabActionSelector": true,
	"autoCollapseExpandSubtreeOnAttach": false,
	"autoCollapseExpandSubtreeOnSelect": false,
	"autoCollapseExpandSubtreeOnSelectExceptCurrentTabRemove": false,
	"collapseExpandSubtreeByDblClick": true,
	"dropLinksOnTabBehavior": 2
}