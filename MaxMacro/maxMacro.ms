(
	struct maxMacro
	(

---------------------
-- GLOBAL COMMANDS --
---------------------

		public TransformMove,
		public TransformRotate,
		public TransformScale,

----------------------------
-- SUB-OBJECT | SELECTION --
----------------------------

		public SelectLoop,
		public SelectRing,
		public SelectGrow,
		public SelectShrink,
		public ConvertToVert,
		public ConvertToEdge,
		public ConvertToFace,
		public ConvertToElement,

---------------------------
-- TOP-LEVEL | OPERATION --
---------------------------

		public Attach,

----------------------------
-- SUB-OBJECT | OPERATION --
----------------------------

		public Bevel,
		public Break,
		public Bridge,
		public Chamfer,
		public Close,
		public Collapse,
		public Connect,
		public Constrain,
		public Create,
		public Cut,
		public Detach,
		public Divide,
		public Duplicate,
		public Extrude,
		public Flatten,
		public Inset,
		public Material,
		public Mirror,
		public Outline,
		public Remove,
		public Smooth,
		public Weld,

----------------------
-- NODE | OPERATION --
----------------------

		public Link,
		public Lock,
		public PivotCenter,
		public PivotInherit,
		public PivotPick,
		public Replace,

----------------------
-- SNAP | OPERATION --
----------------------

		public CoordSystemCycle,
		public CoordCenterCycle,
		public SnapActive,
		public SnapConstraint,

----------------------
-- VIEW | OPERATION --
----------------------

		public ViewProjection,

--------------------
-- MACRO | HELPER --
--------------------

		public function GenerateMacros =
		(
			local name = "";
			local output = StringStream "";

			scripts = Sort (GetPropNames Macro);

			for script in scripts do
			(
				name = script as String;
				name[1] = ToUpper name[1];

				format "macroScript % category:\"Max Macro\" buttonText:\"%\" toolTip:\"%\"\n(\n\tMacro.% ();\n)\n\n" name name name name to:output;
			)

			SetClipboardText (output as String);
			free output;
		)
	)

	Macro = maxMacro ();
)