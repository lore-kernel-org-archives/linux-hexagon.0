Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E13D0934;
	Wed, 19 Aug 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121122; cv=none; b=AR0xzDE88Gu6MuAgPAZUGG7FSjwPkFZ5JUxhAsbEK03uUHriIuhgFNoIRtrGLOOOgR2+CjXBQ9OqvEL3C2mczXZF2iFgc0K4Lbuh/OHbp+VOCsXT3vNkk01jKgYrJdcBRMz7tdHQRylOuKU6/jOevzxfd80QsHek6eoiHLRV3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121122; c=relaxed/simple;
	bh=d4yB2iVy9Yq9ywUwnJltnewCoSvH3w8okFzrn73qoyw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RTyB5FN0OilO0XDSe0O5DrWRh//pIbMclbolJd6VsGpCTf/toImbHXHDhIYMATzbW/7fgKwUf5IwX/yyBnQDiXqpriYcgBCh21cthNGK5TxNKMYsiN6ZiDWVRcJ+zxqfa5gmoDAxBsyuRXGr43jpvRqTP5kFQhaMBPpuAFQVbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cEoPgd+6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cEoPgd+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1787121118;
	bh=d4yB2iVy9Yq9ywUwnJltnewCoSvH3w8okFzrn73qoyw=;
	h=From:Subject:Date:To:Cc:From;
	b=cEoPgd+63pqD+VxOzVVWhtBTCdpyIAzye5F6wrVZAyD//lPcv9IF35RbQIAFWgzLi
	 SeQ+SSUxngPae7fwEwd8LYqQybEhBzhPgHdTwzgnaThUlI1Ch7zMai7WZ1KpagqetH
	 wvknsMmyDkIca4fTMbOffF7s8YUrdPdSHmkNEEIs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] tools/nolibc: hexagon support
Date: Wed, 19 Aug 2026 08:31:50 +0200
Message-Id: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDVp/XMVsaCmjEgrLSKR3l2x/
 Bbv3eDQEjpoohssnuTI6AARRyDnXk/IaAyGhCcFz4Vg2qw0SDbj1U9Gs1RVVS1UJkuFEKLNoqL
 rG7bdb3cMC8r9vYD3D6rS5aByAAAA
X-Change-ID: 20260511-nolibc-hexagon-3f8891f4c7fe
To: Brian Cain <bcain@kernel.org>, Willy Tarreau <w@1wt.eu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787121117; l=850;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=d4yB2iVy9Yq9ywUwnJltnewCoSvH3w8okFzrn73qoyw=;
 b=6AQFQvWtlwXKkJdH2iCMdFSidezwipuAMU1CvGb+YkxN81HcpOzaMNyo6x1F+8+Gn5Fl06xpi
 qsEvsjNEWQXCYKZlTeWxDoc5tbiK5gRb8LGkPhZTz+jZ6/s7VrviZHL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for the hexagon architecture.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      tools/nolibc: split the architecture list into multiple lines
      selftests/nolibc: prepare for clang-only architectures
      tools/nolibc: add support for hexagon

 tools/include/nolibc/Makefile                  |  18 ++-
 tools/include/nolibc/arch-hexagon.h            | 164 +++++++++++++++++++++++++
 tools/include/nolibc/arch.h                    |   2 +
 tools/testing/selftests/nolibc/Makefile.nolibc |   8 ++
 tools/testing/selftests/nolibc/run-tests.sh    |  20 ++-
 5 files changed, 209 insertions(+), 3 deletions(-)
---
base-commit: b58afc8d1cf85688601b8d7e271125fff666f661
change-id: 20260511-nolibc-hexagon-3f8891f4c7fe

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

