Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03546277011
	for <linux-hexagon@vger.kernel.org>; Thu,  4 Sep 2025 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967019; cv=none; b=WfCfslcgt2h3xCDMemrIfkHW+I4KhUVXsC9LMbpEFInlWSqTVowHaG86nDrQnyx3rwOLQt2EMnB8Q9ulY1pF424DO+BCT4v20oPCBao3pChgVD1J4MBIca9v4qG4g5dZDe9kF5sKUD4SzcOtrQMG5EkKAx0lulrzu1UVd/GX8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967019; c=relaxed/simple;
	bh=/EnJgE7OJBZX59ejos7JhFpHDpm1x9yOWxaC8UYxIp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdjWv+K4PTM8/ew2B434TSGRkV/A537bgJYvFKHSQSiunDoJzG+9GEDZnGFu93SklZLjresVXLh+Uyk9g79lCzUq2u8wws2SQPU+uZqR7xpbAKh0edIdYj0Q3GGm14t7g0e8qHl8jmjcThIe/HkG/STUCcjhOYPga2+hXdbSOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEDX2+/3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEDX2+/3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7724ddbcdaeso43744b3a.1
        for <linux-hexagon@vger.kernel.org>; Wed, 03 Sep 2025 23:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756967016; x=1757571816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpJy0SmFfEmeoeaFkzFs+WVa2Vc5JdK+bPJTBjQhA74=;
        b=nEDX2+/3w6o88I1/2zC/XpxuU2gaC6xdL+klCPa6s70Zht9mP/9n7kqxkl7DbutD33
         TrSwS5rWj5xfHS8Pdts01JTrn3IpXmeMGGdO9AaGp/Bdybxo2pfQ793UaZzYPqSgRJM8
         3WYxy9KlJhsWbBu2smAVKGGt4RsPfxBZgO9nppnJacrAaih0K0cFWxIkdtZKwtl+VbvL
         jelQregH5bqPNh6OePYtBzl0hUF8o59mrhyX0rKEb3V+q4uOQdgsUxyDBhnsfDi7EOKj
         4bqAa6mFx919+1sqcHfRAo8Amwqe1LOdBGXi6ZiXMBI2EO986C2PHuR9WfzyfjLbw21R
         9iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967016; x=1757571816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpJy0SmFfEmeoeaFkzFs+WVa2Vc5JdK+bPJTBjQhA74=;
        b=t5uPqV6OzmIeeCHKSQhgOOB/GZmNSa8pe3GDthj6RgfsZypfKtZDurNlxYWot/UTZv
         YCqOPSSU8gAxasrLbWumIt4B1TxXPE2xa2zQpS1JrTNP088JjWnlD73WAN/dkXPj+6xV
         HT/HGP64cuLrPDVB58w4D5EDmxqPnFcXu1Ns8sz5nsC4CksMg/milKqDo4CdS28DMdsa
         zMeRPqnrB1ISBKTpZFQDVkU/Uv4N9B319BQD1/zyyF+AJlt7J3YeBcmQ6wGb8Non4Wi3
         MHaomeFb7lIDc0S9oFfVdemD4WusIQtYfpRbFeBRbJWneFJp1jZRqLqECpuBw2uSXmiC
         COJw==
X-Gm-Message-State: AOJu0Yy81JYQQzMFUzbZDQAWIm6dBrcdc9lbRdR18FMPdq9WLEI1Sxsz
	FKFe9bLZq66memmugAZnp0OKkje5b/yv2ps8S7nbFKylPCrRRH2ARz5E
X-Gm-Gg: ASbGncshw1POxwRviDx0hZwM1hpo5KCzKWEfRLM3AZZocOYB64SAAmscTjo+WLekkym
	qw/s1PP/lLjWCxrx8DLbw/ARrAsqgK7UjYuQBClrZhfEu8dG7YBb8YI3nrwkq1AYz0UtaGceSVJ
	GQwb+ZFw0SNh2Scm+HvM7vBZ7UYMbUEmNek8oqsx4OA8k7ih1EtzAggGh98WYyDVb/VJF1u89OF
	PitcVsS5n5GNTQtXwX9afFsy3FEQB3s62CInXobuQN5J++S54MzGG6KY2L2Ki3BSCGqmz6ilBrn
	xCZ9jXhPpqCWe+mO9Cr07/V+bs4Vw/5I78eZANwftg/fTIjFowAo5QhBDmP/1pnPuJYNZnR2zEG
	7/jtIK/FxxdxL2jqVU1XZJIwDWD1tH3WStvTYCsiFyY3Pleh/
X-Google-Smtp-Source: AGHT+IEBJZvQVehY2sHFoniuE6A9P1WB/bX16Yql21Kl7/uCiWvYj5gVnHq0ENPDwr3ALXi69eZlZA==
X-Received: by 2002:a05:6a00:1c:b0:772:39db:fa09 with SMTP id d2e1a72fcca58-77239dbfb77mr9444420b3a.5.1756967016264;
        Wed, 03 Sep 2025 23:23:36 -0700 (PDT)
Received: from hobbes.T-mobile.com ([2600:70ff:f833:0:8e07:c9e8:902c:6ffa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725f0c4008sm10198397b3a.35.2025.09.03.23.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:35 -0700 (PDT)
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org,
	linux-mm@kvack.org,
	Brian Cain <bcain@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 2/2] fork: change "a mm_struct" to "an mm_struct" in comment
Date: Wed,  3 Sep 2025 20:23:26 -1000
Message-ID: <1c468cd846ba6839fea08df36d8d6e9718625661.1756966290.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756966290.git.joeypabalinas@gmail.com>
References: <cover.1756966290.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct english is "an mm_struct" which is used everywhere else
in the kernel.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 kernel/fork.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499dcaa35e..9a783cd46d097a2d68 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1397,18 +1397,18 @@ static int wait_for_vfork_done(struct task_struct *child,
 	put_task_struct(child);
 	return killed;
 }
 
 /* Please note the differences between mmput and mm_release.
- * mmput is called whenever we stop holding onto a mm_struct,
+ * mmput is called whenever we stop holding onto an mm_struct,
  * error success whatever.
  *
- * mm_release is called after a mm_struct has been removed
+ * mm_release is called after an mm_struct has been removed
  * from the current process.
  *
  * This difference is important for error handling, when we
- * only half set up a mm_struct for a new process and need to restore
+ * only half set up an mm_struct for a new process and need to restore
  * the old one.  Because we mmput the new mm_struct before
  * restoring the old one. . .
  * Eric Biederman 10 January 1998
  */
 static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
-- 
Cheers,
Joey Pabalinas

