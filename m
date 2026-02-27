Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D93603C5;
	Fri, 27 Feb 2026 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174286; cv=none; b=EMeeVxr+TRr/poYsQUaHdeUZ1Ne16UXlt3Z7kwxpvEhPAexEkb1vzm9H3rbXhXAvzdpLBFFPyAIwUA2nskEzTakQxf+r1uAXwlQh03d74PI+gKr0g5Q6Qo6Fp/S2O7+lNdsoiDimRWpKm9FGoTvHyWLScLAilELMtuTLutU5VG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174286; c=relaxed/simple;
	bh=HPssK7+gGKc7Yv4nCoiB8PrNhJJvn3JdkcnAkho+spA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LnDX/47X4z3ZgeU+mKcZWHseJgybhTyGF4354s5itW0TJFBTgs9QeRTyBR0KHf3oyhoQgbrGZcjbYtrSsw83HtXlChLNdh1E+9k80+wMBz9DjiL78G5xGK+fyGcDne37n9U2gz/LCqTYYGLqYePGvTaPKINhbc3rQ4rEXtBO9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HFkmz0WR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HFkmz0WR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772174282;
	bh=HPssK7+gGKc7Yv4nCoiB8PrNhJJvn3JdkcnAkho+spA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HFkmz0WRE6Vwez6AQ7fW6zP/c7q3CcHVxGDRXvovNpzdUMSi/Rd6y6906FfPDwECl
	 BwmTkPjNFDuTbPlrCNNiTX+sbiFZ+CTQGZ9KKFCdB5oRSuONJSX3C3yx7ugAaK6eOG
	 69s3RJhUBW/fkdB1Fn6siO/KfSktS4n5Jc4rAgMw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 27 Feb 2026 07:38:00 +0100
Subject: [PATCH 2/9] kbuild: uapi: test linux/bpf_perf_event.h on powerpc
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-kbuild-uapi-libc-v1-2-c17de0d19776@weissschuh.net>
References: <20260227-kbuild-uapi-libc-v1-0-c17de0d19776@weissschuh.net>
In-Reply-To: <20260227-kbuild-uapi-libc-v1-0-c17de0d19776@weissschuh.net>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Brian Cain <bcain@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174282; l=608;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HPssK7+gGKc7Yv4nCoiB8PrNhJJvn3JdkcnAkho+spA=;
 b=Ww+BrPFtwChLKvwb286tEK6HAq/M1dsX+1wdZKwZUxEZLEsm+Hnq54GTN6NCTl5GUW1mPiAaX
 KWPRfwu2btmB+x/r7FuAIWGKkOyx7jcnqxdOyJwG0Q5JXbBwjU3yD3Q
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This header works now, so test it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 usr/include/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index 6d86a53c6f0a..595996eefcc6 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -56,10 +56,6 @@ ifeq ($(SRCARCH),openrisc)
 no-header-test += linux/bpf_perf_event.h
 endif
 
-ifeq ($(SRCARCH),powerpc)
-no-header-test += linux/bpf_perf_event.h
-endif
-
 ifeq ($(SRCARCH),sparc)
 no-header-test += asm/uctx.h
 no-header-test += asm/fbio.h

-- 
2.53.0

