Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5A53BBA04;
	Wed, 19 Aug 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121123; cv=none; b=B9gnU5Y0+j2sW9C1zW0++vrSup64Kw27u8/KmM+qZp5toUIhq3zwub4hfKGuJFXIhH8GscZ1nuI+PjGnMv0Yu0rsHrDoOhWuK0nVHbXIYj483q/JHSH3WE0Q5OLyNzIi5T5wiLE4hvFzeMnMNivAwZnjraZ2k8zmh0x3hnSZMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121123; c=relaxed/simple;
	bh=ALQgJA8GzlWNdWB83Ze5vhtNM5ea+XJx7aEj3bOV6oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=td78JiqsgxEHsmNuWFyIiDOp5J1Uu/61yQ75W9HyOmjutYc/r9+HR28I7TTpHlOCkVZK/v2afG8reJVdL4y4mW/emcHNLsLa0gYpxl+vrCfzLQ1YezOOW3uPRZzUbFvSuJwD2Z2Lj205X0EQs5PrFPc2Gc8g7rNbukRMnVcaaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VhqNCtJx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VhqNCtJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1787121118;
	bh=ALQgJA8GzlWNdWB83Ze5vhtNM5ea+XJx7aEj3bOV6oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VhqNCtJxosEXzyDkWeNhz6BZWCnT7JNbTDPsj3ZQzPOmGL8YpN7mwowGqVrWu3woh
	 zcDVj4lddiIVFnWuocg0Ryy9oCSZwdXLkB44C/QBM+xju/D5nAyI7lJsFxusclBWUU
	 40I2HgbwERv14Vih/s67OcQl8KP4AbC77+g3+xeQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 19 Aug 2026 08:31:51 +0200
Subject: [PATCH 1/3] tools/nolibc: split the architecture list into
 multiple lines
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-nolibc-hexagon-v1-1-6bc3be591f09@weissschuh.net>
References: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
In-Reply-To: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
To: Brian Cain <bcain@kernel.org>, Willy Tarreau <w@1wt.eu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787121117; l=936;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ALQgJA8GzlWNdWB83Ze5vhtNM5ea+XJx7aEj3bOV6oc=;
 b=mvICwTAr6jhekqOis35OBD+XVlEOwxnVNRGJc/qaeybGqqjjSTaxGnaa9YdxgsNHolC1E3fiA
 0oXrx6HsIvOB+2vuGFq1PH85VXNO/vPMf7zY0+MX6xTMpDcR5YhQYsw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The list is getting long, split it up for easier additions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 6d213d372bf8..b5897b3964f8 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -17,7 +17,22 @@ endif
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
 
-architectures := alpha arm arm64 loongarch m68k mips openrisc parisc powerpc riscv s390 sh sparc x86
+architectures := \
+		alpha \
+		arm \
+		arm64 \
+		loongarch \
+		m68k \
+		mips \
+		openrisc \
+		parisc \
+		powerpc \
+		riscv \
+		s390 \
+		sh \
+		sparc \
+		x86 \
+
 arch_files := arch.h $(addsuffix .h, $(addprefix arch-, $(architectures)))
 all_files := \
 		alloca.h \

-- 
2.55.0

