Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC73101C0;
	Mon, 22 Dec 2025 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766389269; cv=none; b=Ug4sUQiXmncgiqqWW5dzjH4xaHfRLfXzJDukAx2tlfaU7Luw/NLuYTTvJNBIAhEca7afLZuHrTqGLmwzu45pxwA4xDE6ZMnHd3OaV7gsx1C/OC7I4crkpXXviHQ57V0YxAEy6piivSGAmCt1GX/ik8RJKoJbJL+255vSE6OoXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766389269; c=relaxed/simple;
	bh=20Jzfcxwvd8WNTSlqh8yUovJSlnzxx9t29vXrdr4S6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GpC6Bbifcgp6vlmkj1o0kr5eOY27+MyxQ4j8lbyJ/+NQeSDEQZFI2Katmzmr5pt5BslMMwWfdwtERaIyuLIIUjvRdRW5wVeJ7RbRsICcjrdb2vtlDtw/je0Rn55tC5OjxncqP9QYJlG3X7iEZbMG5jZjGedHdIniFyZys2FdnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RmkuxGRQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dpr7yMrT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RmkuxGRQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dpr7yMrT"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766389264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jWdAY6sBKx6S0PxNvf/DvGbHLBB0BlqRAuGVx2twGYw=;
	b=RmkuxGRQwTE5nuQgYveoVD7amd1dv5HcsEGMzOMUAyYc6ZAqAgdExtNf5KNwuxgw+TLDkR
	wJ7MN9FIjNJkkK72DUrIpEdopnKixYS8A7uKxYDz1Z+ExYqYpjj2oOEcmEh89wDvnngXYg
	ZF4tcxeqUEC6Qah+w3aP1kWxbjXPz49cXsLck0xeeppdcfzxgqf4rRj9QhE0LtR0qK8BxT
	cZQmqFpBrAf8XzP/A/QDRZ0rsCxZmzJFubmHLWVfNrOAStEfmN3U5Sj4AHUzdUHUDyNmk1
	DYycKyFv75fKe8vxYVcminlrXLroHW3eyyVv9CnqB81ASoYEQhohKab9QNyiNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766389264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jWdAY6sBKx6S0PxNvf/DvGbHLBB0BlqRAuGVx2twGYw=;
	b=dpr7yMrTomhC9pwTETqcUBICH2CO6KA1/7VkH8CA7ZIzXBafphQ4tBrKrJhzjA69zKewQs
	YA0qVjHkabpvsZCg==
Date: Mon, 22 Dec 2025 08:40:56 +0100
Subject: [PATCH] hexagon: uapi: Fix structure alignment attribute
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251222-uapi-hexagon-v1-1-192bf7d9d702@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAf2SGkC/x3MQQqAIBBA0avErBNsorCuEi0kR52NilIE4t2Tl
 m/xf4VCmanAPlTI9HDhGDqmcYDL6+BIsOkGlLhMiChunVh4erWLQVi7bjQrOaMy0JOUyfL7746
 ztQ/vNFkmXgAAAA==
X-Change-ID: 20251222-uapi-hexagon-ff69e380328d
To: Brian Cain <bcain@kernel.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766389263; l=881;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=20Jzfcxwvd8WNTSlqh8yUovJSlnzxx9t29vXrdr4S6c=;
 b=EtHtVvGiGcxQllUOmfoMutmrvArlhTQ61GqWPlf4hYV3/lEFcV1LfgStlbsncuWGkgZbvZmn/
 ZIDsPBqYA+NBPlcqic59iPDOQOVhMDp5zwGYGtPWEXcZh79MgSFsWwc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

__aligned() is a kernel macro, which is not available in UAPI headers.

Use the compiler-provided alignment attribute directly.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/hexagon/include/uapi/asm/sigcontext.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/uapi/asm/sigcontext.h b/arch/hexagon/include/uapi/asm/sigcontext.h
index 7171edb1b8b7..179a97041b59 100644
--- a/arch/hexagon/include/uapi/asm/sigcontext.h
+++ b/arch/hexagon/include/uapi/asm/sigcontext.h
@@ -29,6 +29,6 @@
  */
 struct sigcontext {
 	struct user_regs_struct sc_regs;
-} __aligned(8);
+} __attribute__((aligned(8)));
 
 #endif

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-uapi-hexagon-ff69e380328d

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

