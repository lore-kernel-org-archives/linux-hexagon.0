Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AA47CC75
	for <linux-hexagon@vger.kernel.org>; Fri,  4 Sep 2026 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519415; cv=none; b=IJflVlBj0DonZR/bs8qyGhEJSjP5vjNwB7QfPaTKnEBn9+YBIL8M/EH0oK96Eu1r2u9cG8hXJBYKDNDofcjmT+d/40gBg7b7NrINoTWFzt+a/ah+pZlRsobc5hQXI9dT3mEqv2tP8ZA7EooG1WxoeBpnJ5xoqg3aW+MnDt+e6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519415; c=relaxed/simple;
	bh=L3q78bqrpMJk/g5QJst8moEgJEW0mjslfg//pWTk2/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZdEwMdT2A4t75xMeRxFoYfrTAUITYpgguFS9rru7T26KJ2mW/3y1tp4wr52/1BJl1lctAG/bsdYhAn70+Ujspi0XbeCgsMj0Uj2Qv+resSVi7ompx1f9js/rfxcm7XyxQfaVjXeOL1RSaK0lYK+rUfh1FEArRd+ZGVPN/9AmUGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU66HQU3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU66HQU3"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398b3c37877so832877a91.0
        for <linux-hexagon@vger.kernel.org>; Fri, 04 Sep 2026 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519412; x=1789124212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIAgfjkMoEY865Ezpezchwh3HIj0Yl8K2XqbGFpjZ+U=;
        b=dU66HQU3sdI3Rj0m0/x2nY7lwyBx72wHy9Em0pNLWyp5WEAAzAPBBqIUOwBocYZB7+
         1+um0OZdOB3Omqj1boZcUrHw/NfMdXzr4VHdU71ZOmyiBdZLY+lHcyEFbNd/ps+K9q5v
         JwH8XDcHqwcwWjMKfopA10iIZDWjBhgS9HT9vO7T9tw9m7jp5psjO6Y+aLwz+cUoNpbN
         0oA7irvEAbxcdZ3i56rXUtPOEYn8acCd8RKWxNxsA6zhpbWd7jl3LUNscgKxF8ONdWop
         BL7KNa5KOMPMu7FcmuIN1/r1b4W8ONNfBFfcG+Bo+papEwyS6UWySe+LTDx7Bpb+kcDW
         TKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519412; x=1789124212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIAgfjkMoEY865Ezpezchwh3HIj0Yl8K2XqbGFpjZ+U=;
        b=TOf/ni6iqBW978dKOQnhQUja6/G+9MOV/m8KIcQK1cfRwyP6LcmT1FMpGKXOEHZz8n
         36xJ/UvB7DM1NxJWA7+7+8EWWdCdkTEXt2Gd2CXmOhpOvRk1ZEvx9Roh9TVhNcIYTYKe
         hOmG1bCMZf1S/Vhmt/mhXAWDVekdFRpVDHSwoy9sW4MEDP+szJydCXTzjbQ9tkKDuScZ
         4U3L5oQatGIBB/NLRdG93yLLcLh4XwFADV3KfpcicC0XhpWZ8ArFy220m5L3WLjzfmLl
         Lvu6NJUJXvNTn0InXKBwDopLfLBhgFWTLzrgQLV3tz4r0UbsTvaShw18TQQoN3r2NHXh
         1vcw==
X-Forwarded-Encrypted: i=1; AKwUvBxDAPNhF19buiW8lOWQuYuqhwRIRgW8juahK3oe4aJtwAXki5AlAPwULZKeFGeiyHZhL2JZtdQfpvP0Se5Y@vger.kernel.org
X-Gm-Message-State: AFuF++m9+tnQH0LQcp9MfxrfU6ZTWXZlU/2m6iO/Y1imt0glTBQHyT1N
	GgAIBeJ2wy2ZqWA7NFkpb3B0KnSAqDR7REHcnbHRRekQawzlAcpfFu1n
X-Gm-Gg: AYBFou1+C9gvI3lS3UqQCRQkoZY3qBynK16YxuV2gsuV/liNNWUeRFcpRDTCsoQElDr
	cPESBLk2jETHMaRCEPjrljYbKjHGztnNOoI5nnK7ZkfvjBAaWoRmzK2wZlGaR1+bbNcS/nPaSMl
	0kroUlKGSt+Kgo9s1XmNhgOVtp+Z4DN9H3V4cSeAGqynLebwLmj+BA5iS4ye62pDrVqiVij025L
	UMc37ddpaLMds3dVO6EpGSSqRuQdd7vPHD+e8PYKYa6WilQk6MJPLZ0t3yXBbsjKkyLD9zoiYPe
	lBJ8Tzdkt1u34UzZkZIfW4hJd3B9RKn3SC64/R0UB1/svqB4IrwY3Mz0bGbZ+w2w7OwI80sCTaH
	sxchb2O1l2Odrzc6jKiNNfJ8WSvhuqDl2guQ0gi5bqUoWl4fCO2w5vJGpHWPn79XQE2OdBAE9h7
	yBcSen2/n3G6kAghvHJ1sFu7vw2fmuTkhmIL6R1VgHMijbLXRzBw9WQWn1MAvp/IQErJWi2qBQI
	90GLZqPHh/EJJE=
X-Received: by 2002:a17:90b:3d89:b0:396:5fce:8e24 with SMTP id 98e67ed59e1d1-39b260d2ea8mr7099437a91.4.1788519412234;
        Fri, 04 Sep 2026 03:56:52 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b6036fcsm6233396eec.20.2026.09.04.03.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:56:51 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Brian Cain <bcain@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-hexagon@vger.kernel.org
Subject: [PATCH] hexagon: fix typos in comments
Date: Fri,  4 Sep 2026 16:26:46 +0530
Message-ID: <20260904105647.38515-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/hexagon/include/asm/hexagon_vm.h | 2 +-
 arch/hexagon/lib/memcpy.S             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include/asm/hexagon_vm.h
index 9aa2493fe786..1a65dc6213b7 100644
--- a/arch/hexagon/include/asm/hexagon_vm.h
+++ b/arch/hexagon/include/asm/hexagon_vm.h
@@ -239,7 +239,7 @@ static inline long __vmintop_clear(long i)
 #define HVM_EV_GENEX		2
 #define HVM_EV_TRAP		8
 #define HVM_EV_INTR		15
-/* These shoud be nuked as soon as we know the VM is up to spec v0.1.1 */
+/* These should be nuked as soon as we know the VM is up to spec v0.1.1 */
 #define HVM_EV_INTR_0		16
 #define HVM_MAX_INTR		240
 
diff --git a/arch/hexagon/lib/memcpy.S b/arch/hexagon/lib/memcpy.S
index f8b3c02a8ad1..ae360be68b0d 100644
--- a/arch/hexagon/lib/memcpy.S
+++ b/arch/hexagon/lib/memcpy.S
@@ -291,7 +291,7 @@ memcpy:
 	if(noprolog) jump .Lnoprolog32;
 	align = offset;
 }
-/*  upto initial 7 bytes  */
+/*  up to initial 7 bytes  */
 {
 	ldata0 = valignb(dataF8, data70, align);
 	ifbyte = tstbit(shift,#3);
@@ -525,5 +525,5 @@ memcpy:
 	r25:24 = memd(sp+#8);	/*  restore r24+r25  */
 	r17:16 = memd(sp+#0);	/*  restore r16+r17  */
 }
-	deallocframe;	/*  restore r31 and incrment stack by 16  */
+	deallocframe;	/*  restore r31 and increment stack by 16  */
 	jumpr r31
-- 
2.48.1

