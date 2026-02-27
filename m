Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426B3603F0;
	Fri, 27 Feb 2026 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174286; cv=none; b=SL+g45u65aLFdltI6rCWnIlraE+r6/lQR0fQ2/WbOZvNwGE3OOEnCjPW2hzCMoofCTMvtkmEBvJ1Qz1fqpbuESgN6UZrJ1zh18ZRwMQbyM5j8TOJVIlKNtr6SvGzUUjISP0DnjkWwCU64DRqLMjiaRlmCPa48meArouSZgG/O2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174286; c=relaxed/simple;
	bh=6diDtqP76C4bz7vahdMwZQipsDirHjMTmlGVgSTA9j0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NlS99WvSxpR7AjMz/7jCJcjSe0gehLJAiFMerMyMkAOQspoI8pMEODlDEoMotrDeqZf6oJFRCBqo5uq5mTbTb7kmibpo10w1YFkMc0sArivz9PqkhLil9wx/D98I+uwGtftk1sGu7IbIGXO83m78GU1cGrLWeXIDtTlJcs1ij4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eSv9gs7p; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eSv9gs7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772174282;
	bh=6diDtqP76C4bz7vahdMwZQipsDirHjMTmlGVgSTA9j0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eSv9gs7p/lZCPvoGnxndoMOVhc98L+FGjMH8NrPE662UHoDjrGS7HjSJRnWsTWVXt
	 CHktg0wESJZC82QhEB/MlgjYt2i/53bFf+cwg+hh7VxSwmn3X8jIa++Qh+eR8UQJVN
	 1Q7JjfYKrrP5SGEAC8WpTdbgrHnqmGaPMtIAyH24=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 27 Feb 2026 07:37:59 +0100
Subject: [PATCH 1/9] hexagon: uapi: Fix structure alignment attribute
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-kbuild-uapi-libc-v1-1-c17de0d19776@weissschuh.net>
References: <20260227-kbuild-uapi-libc-v1-0-c17de0d19776@weissschuh.net>
In-Reply-To: <20260227-kbuild-uapi-libc-v1-0-c17de0d19776@weissschuh.net>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Brian Cain <bcain@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174282; l=753;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hO3aEDa72rKRx1PRZun2eaHfd644nVshBCoBoGCyGWY=;
 b=I4SH8uv7U74uSWwUxmrtdVXuy7xtDFBQUnMTJogHIoldXFI0oy99HggNVFTAw5owSyadcQJSr
 LbS02jR+YAjDeh0XzT398x8cQTkmMPFbd7Ksy5yRupgXIrUM5mx4cMp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

__aligned() is a kernel macro, which is not available in UAPI headers.

Use the compiler-provided alignment attribute directly.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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

-- 
2.53.0

