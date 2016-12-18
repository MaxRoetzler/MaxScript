(
	struct maxMacro
	(
		public EPoly,
		public MPoly,
		public ELine,
		public MUvw,
		public Node,

---------------------
-- GLOBAL COMMANDS --
---------------------

		public function TransformMove =
		(
			case (Core.Node.GetObjectType ()) of
			(
				Default 	: max Move;
				#UnwrapUVW	: $.Unwrap_UVW.Move ();
			)
		),

		public function TransformRotate =
		(
			case (Core.Node.GetObjectType ()) of
			(
				Default 	: max Rotate;
				#UnwrapUVW	: $.Unwrap_UVW.Rotate ();
			)
		),

		public function TransformScale =
		(
			case (Core.Node.GetObjectType ()) of
			(
				Default 	: max Scale;
				#UnwrapUVW	: $.Unwrap_UVW.Scale ();
			)
		),

----------------------------
-- SUB-OBJECT | SELECTION --
----------------------------

		public function SelectLoop =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.SelectLoop $;
				#EditablePoly	: Macro.EPoly.SelectLoop $;
				#UnwrapUVW		: Macro.MUvw.SelectLoop $;
			)
		),

		public function SelectRing =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.SelectRing $;
				#EditablePoly	: Macro.EPoly.SelectRing $;
				#UnwrapUVW		: Macro.MUvw.SelectRing $;
			)
		),

		public function SelectGrow =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.SelectGrow $;
				#EditablePoly	: Macro.EPoly.SelectGrow $;
				#EditableLine	: Macro.ELine.SelectGrow $;
				#UnwrapUVW		: Macro.MUvw.SelectGrow $;
			)
		),

		public function SelectShrink =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.SelectShrink $;
				#EditablePoly	: Macro.EPoly.SelectShrink $;
				#EditableLine	: Macro.ELine.SelectShrink $;
				#UnwrapUVW		: Macro.MUvw.SelectShrink $;
			)
		),

		public function ConvertToVert =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.ConvertToVert $;
				#EditablePoly	: Macro.EPoly.ConvertToVert $;
				#EditableLine	: Macro.ELine.ConvertToKnot $;
				#UnwrapUVW		: Macro.MUvw.ConvertToVert $;
			)
		),

		public function ConvertToEdge =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.ConvertToEdge $;
				#EditablePoly	: Macro.EPoly.ConvertToEdge $;
				#EditableLine	: Macro.ELine.ConvertToSegment $;
				#UnwrapUVW		: Macro.MUvw.ConvertToEdge $;
			)
		),

		public function ConvertToFace =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.ConvertToFace $;
				#EditablePoly	: Macro.EPoly.ConvertToFace $;
				#EditableLine	: Macro.ELine.ConvertToSpline $;
				#UnwrapUVW		: Macro.MUvw.ConvertToFace $;
			)
		),

		public function ConvertToElement =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.ConvertToElement $;
				#EditablePoly	: Macro.EPoly.ConvertToElement $;
				#EditableLine	: Macro.ELine.ConvertToSpline $;
				#UnwrapUVW		: Macro.MUvw.ConvertToElement $;
			)
		),

---------------------------
-- TOP-LEVEL | OPERATION --
---------------------------

		public function Attach =
		(
			case (Core.Node.GetObjectType subLevel:-1) of
			(
				#EditPoly		: Macro.MPoly.Attach $;
				#EditablePoly	: Macro.EPoly.Attach $;
				#EditableLine	: Macro.ELine.Attach $;
				#UnwrapUVW		: Macro.MUvw.Stitch $;
			)
		),

----------------------------
-- SUB-OBJECT | OPERATION --
----------------------------

		public function Bevel =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Bevel $;
				#EditablePoly	: Macro.EPoly.Bevel $;
				#EditableLine	: Macro.ELine.Fillet $;
			)
		),

		public function Break =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Break $;
				#EditablePoly	: Macro.EPoly.Break $;
				#EditableLine	: Macro.ELine.Break $;
				#UnwrapUVW		: Macro.MUvw.Break $;
			)
		),

		public function Bridge =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Bridge $;
				#EditablePoly	: Macro.EPoly.Bridge $;
			)
		),

		public function Chamfer =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Chamfer $;
				#EditablePoly	: Macro.EPoly.Chamfer $;
				#EditableLine	: Macro.ELine.Chamfer $;
			)
		),

		public function Close =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Close $;
				#EditablePoly	: Macro.EPoly.Close $;
				#EditableLine	: Macro.ELine.Close $;
			)
		),

		public function Collapse =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Collapse $;
				#EditablePoly	: Macro.EPoly.Collapse $;
				#EditableLine	: Macro.ELine.Collapse $;
				#UnwrapUVW		: Macro.MUvw.Collapse $;
				#Selection		: Macro.Node.Collapse ();
			)
		),

		public function Connect =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Connect $;
				#EditablePoly	: Macro.EPoly.Connect $;
				#EditableLine	: Macro.ELine.Connect $;
			)
		),

		public function ConstrainEdge =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Constrain $ 1;
				#EditablePoly	: Macro.EPoly.Constrain $ 1;
			)
		),

		public function ConstrainNormal =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Constrain $ 3;
				#EditablePoly	: Macro.EPoly.Constrain $ 3;
			)
		),

		public function Create =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Create $;
				#EditablePoly	: Macro.EPoly.Create $;
				#EditableLine	: Macro.ELine.Create $;
			)
		),

		public function Cut =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Cut $;
				#EditablePoly	: Macro.EPoly.Cut $;
				#EditableLine	: Macro.ELine.Cut $;
			)
		),

		public function Detach =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Detach $;
				#EditablePoly	: Macro.EPoly.Detach $;
				#EditableLine	: Macro.ELine.Detach $;
				#UnwrapUVW		: Macro.MUvw.Break $;
			)
		),

		public function Divide =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Divide $;
				#EditablePoly	: Macro.EPoly.Divide $;
				#EditableLine	: Macro.ELine.Divide $;
			)
		),

		public function Duplicate =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Duplicate $;
				#EditablePoly	: Macro.EPoly.Duplicate $;
				#EditableLine	: Macro.ELine.Duplicate $;
				#Selection		: Macro.Node.Duplicate ();
			)
		),

		public function Extrude =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Extrude $;
				#EditablePoly	: Macro.EPoly.Extrude $;
			)
		),

		public function Flatten =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Flatten $;
				#EditablePoly	: Macro.EPoly.Flatten $;
				#EditableLine	: Macro.ELine.Flatten $;
			)
		),

		public function Inset =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Inset $;
				#EditablePoly	: Macro.EPoly.Inset $;
			)
		),

		public function Material0 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Material $ 0;
				#EditablePoly	: Macro.EPoly.Material $ 0;
				#Selection		: Macro.Node.Material 0;
			)
		),

		public function Material1 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Material $ 1;
				#EditablePoly	: Macro.EPoly.Material $ 1;
				#Selection		: Macro.Node.Material 1;
			)
		),

		public function Material2 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Material $ 2;
				#EditablePoly	: Macro.EPoly.Material $ 2;
				#Selection		: Macro.Node.Material 2;
			)
		),

		public function Material3 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Material $ 3;
				#EditablePoly	: Macro.EPoly.Material $ 3;
				#Selection		: Macro.Node.Material 3;
			)
		),

		public function Material4 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Material $ 4;
				#EditablePoly	: Macro.EPoly.Material $ 4;
				#Selection		: Macro.Node.Material 4;
			)
		),

		public function Material5 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Material $ 5;
				#EditablePoly	: Macro.EPoly.Material $ 5;
				#Selection		: Macro.Node.Material 5;
			)
		),

		public function Material6 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Material $ 6;
				#EditablePoly	: Macro.EPoly.Material $ 6;
				#Selection		: Macro.Node.Material 6;
			)
		),

		public function Material7 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Material $ 7;
				#EditablePoly	: Macro.EPoly.Material $ 7;
				#Selection		: Macro.Node.Material 7;
			)
		),

		public function Material8 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Material $ 8;
				#EditablePoly	: Macro.EPoly.Material $ 8;
				#Selection		: Macro.Node.Material 8;
			)
		),

		public function Material9 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Material $ 9;
				#EditablePoly	: Macro.EPoly.Material $ 9;
				#Selection		: Macro.Node.Material 9;
			)
		),

		public function Mirror =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Mirror $;
				#EditablePoly	: Macro.EPoly.Mirror $;
				#EditableLine	: Macro.ELine.Mirror $;
				#Selection		: Macro.Node.Mirror ();
			)
		),

		public function Outline =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Outline $;
				#EditablePoly	: Macro.EPoly.Outline $;
				#EditableLine	: Macro.ELine.Outline $;
			)
		),

		public function Remove =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Remove $;
				#EditablePoly	: Macro.EPoly.Remove $;
				#EditableLine	: Macro.ELine.Remove $;
				#Selection		: Macro.Node.Remove ();
			)
		),

		public function Smooth0 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Smooth $ 0;
				#EditablePoly	: Macro.EPoly.Smooth $ 0;
				#EditableLine	: Macro.ELine.Smooth $ 0;
			)
		),

		public function Smooth1 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Smooth $ 1;
				#EditablePoly	: Macro.EPoly.Smooth $ 1;
				#EditableLine	: Macro.ELine.Smooth $ 1;
			)
		),

		public function Smooth2 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Smooth $ 2;
				#EditablePoly	: Macro.EPoly.Smooth $ 2;
				#EditableLine	: Macro.ELine.Smooth $ 2;
			)
		),

		public function Smooth3 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Smooth $ 3;
				#EditablePoly	: Macro.EPoly.Smooth $ 3;
				#EditableLine	: Macro.ELine.Smooth $ 3;
			)
		),

		public function Smooth4 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Smooth $ 4;
				#EditablePoly	: Macro.EPoly.Smooth $ 4;
			)
		),

		public function Smooth5 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Smooth $ 5;
				#EditablePoly	: Macro.EPoly.Smooth $ 5;
			)
		),

		public function Smooth6 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Smooth $ 6;
				#EditablePoly	: Macro.EPoly.Smooth $ 6;
			)
		),

		public function Smooth7 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Smooth $ 7;
				#EditablePoly	: Macro.EPoly.Smooth $ 7;
			)
		),

		public function Smooth8 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Smooth $ 8;
				#EditablePoly	: Macro.EPoly.Smooth $ 8;
			)
		),

		public function Smooth9 =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Smooth $ 9;
				#EditablePoly	: Macro.EPoly.Smooth $ 9;
			)
		),

		public function Weld =
		(
			case (Core.Node.GetObjectType ()) of
			(
				#EditPoly		: Macro.MPoly.Weld $;
				#EditablePoly	: Macro.EPoly.Weld $;
				#EditableLine	: Macro.ELine.Weld $;
				#UnwrapUvw		: Macro.MUvw.Weld $;
			)
		),

----------------------
-- NODE | OPERATION --
----------------------

		public function Link =
		(
			if (Core.Node.GetObjectType () == #Selection) do
			(
				local target = PickObject rubberBand:selection.Center;

				if (target != #Escape) do
				(
					selection.Parent = undefined;

					if (target != undefined) do
					(
						for node in selection where (node != target) do
						(
							node.Parent = target;
						)
					)
				)
			)
		),

		public function Lock = 
		(
			if (Core.Node.GetObjectType () == #Selection) do
			(
				local flag = #None;
				local total = 0.0;

				for node in selection do
				(
					total += (GetTransformLockFlags node).NumberSet;
				)

				if ((total / selection.Count) < 5) do flag = #All;

				for node in selection do
				(
					SetTransformLockFlags node flag;
				)
			)
		),

		public function PivotCenter =
		(
			if (Core.Node.GetObjectType () == #Selection) do
			(
				for node in selection do
				(
					node.Pivot = node.Center;
				)
			)
		),

		public function PivotInherit =
		(
			if (Core.Node.GetObjectType () == #Selection) do
			(
				local target = PickObject rubberBand:selection.Center;

				if (IsValidNode target) do
				(
					selection.Pivot = target.Pivot;
				)
			)
		),

		public function PivotPick =
		(
			if (Core.Node.GetObjectType () == #Selection) do
			(
				local snapData = Core.Util.SnapData ();
				Core.Util.SetSnap #(7,1) #Exclusive;

				local target = PickPoint snap:#3D rubberBand:selection.Center;

				if (ClassOf target == Point3) do
				(
					selection.Pivot = target;
				)

				snapData.Reset ();
			)
		),

		public function Replace =
		(
			if (Core.Node.GetObjectType () == #Selection) do
			(
				local target = PickObject rubberBand:selection.Center;

				case target of
				(
					Default		: InstanceReplace selection target;
					undefined	: InstanceMgr.MakeObjectsUnique selection #Group;
				)
			)
		),

----------------------
-- SNAP | OPERATION --
----------------------

		public function CycleCoordSystem =
		(
			case (GetRefCoordSys()) of
			(
				Default: SetRefCoordSys #Hybrid;
				#Hybrid: SetRefCoordSys #Local;
				#Local:	 SetRefCoordSys #Hybrid;
			)

			--Core.RaiseEvent #OnCoordSysChanged;
		),

		public function CycleCoordCenter =
		(
			case (GetCoordCenter ()) of
			(
				Default: 	SetCoordCenter #Local;
				#Selection: SetCoordCenter #Local;
				#Local: 	SetCoordCenter #Selection;
			)
		),

		public function SnapActive =
		(
			snapMode.Active = not snapMode.Active;
			--Core.RaiseEvent #OnSnapStateChanged;
		),

		public function SnapConstraint =
		(
			snapMode.AxisConstraint = not snapMode.AxisConstraint;
		),

----------------------
-- VIEW | OPERATION --
----------------------

		public function ViewProjection =
		(
			local type = viewport.GetType ();

			with Redraw off
			(
				if (SuperClassOf $ == Camera and type != #View_Camera) then
				(
					max vpt camera;
				)
				else if (type != #View_Persp_User) then
				(
					max vpt persp user;
					ActionMan.ExecuteAction 0 "40228";	-- Save persp. view
				)
				else
				(
					ActionMan.ExecuteAction 0 "40227";	-- Restore persp. view
					Viewport.SetTm (Inverse (Core.Util.AlignMatrixToView ()));

					max vpt iso user;
					max zoomext sel;
				)
			)

			--Core.RaiseEvent #OnViewportChanged;
			RedrawViews ();
		),

--------------------
-- MACRO | HELPER --
--------------------

		public function GenerateMacros =
		(
			local name = "";
			local output = StringStream "";

			local ignored = #(#EPoly, #MPoly, #ELine, #Node, #GenerateMacros)
			local scripts = Core.Util.SubtractArrays (GetPropNames Macro) ignored;

			Sort scripts;

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