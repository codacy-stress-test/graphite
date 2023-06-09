// SPDX-License-Identifier: MIT OR MPL-2.0 OR LGPL-2.1-or-later OR GPL-2.0-or-later
// Copyright (C) 2012 SIL International
using System;
using NUnit.Framework;
using NGraphite;

namespace NGraphiteTests
{
	[TestFixture()]
	public class FontTests
	{
		[Test()]
		public void Font_FromTestFace_DoesNotThrowException()
		{
			using (var face = new Face(TestConstants.PaduakFontLocation, FaceOptions.face_default))
			{
				new Font(20.0f, face).Dispose();
			}
		}
		
		[Test()]
		public void MakeSeg_WithTestString_ReturnsNonNullSegment()
		{
			using (var face = new Face(TestConstants.PaduakFontLocation, FaceOptions.face_default))
			{
				using (var font = new Font(20.0f, face))
				{
					using(Featureval featureval = face.FeaturevalForLang("en"))
					{
						Segment segment = font.MakeSeg(0, featureval, "hello world", Bidirtl.Nobidi);
						Assert.NotNull(segment);
						segment.Dispose();
					}
				}
			}
		}
	}
}

