Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21A1953A9;
	Mon, 23 Sep 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099561; cv=none; b=Tz9XAJYC3/Hi6ojBNg9x1vbLtebjZVK1Cs/AJ6LrXAUfLBQxDoNsByXVflAT5Zy6ibOIOzBbVd33jMp2GRheJI+57kppWiksyDEyFytvG3jlqbbwaUqtT31td8VLsrev2uRlzQum3eoGBavuqmj8SooIdHxZUy1Hij82GYsF7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099561; c=relaxed/simple;
	bh=qkP2UH+/9fa1nxEHJHixUFqfgsCJZAlJU5fn2V3oh7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMhQZBMoyPPO19BzpAvtOXYdJDUSQRJo/vFmNvVZAlFr+jR85127x3PGOddYOsGv0l/hfGORx03sjZRcXg/8su4RG8UsVRlJW4wunlfvRN8GhHzLRPNR+bfAyI0MTRKWLI41cnMLcehCahgr7aei3hsFRU5KeXjyqpcOdFSKUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrRB8jfF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrRB8jfF"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718816be6cbso3261033b3a.1;
        Mon, 23 Sep 2024 06:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727099560; x=1727704360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rxx15U318d5m06Ojgqj0DzpCwDVhOZTk+ahf/TNfxMI=;
        b=KrRB8jfFp6yy6DDYgn70liVo6bJkouQ1IvJlYUR6UDQyjf7ttT8Kd1rk5mH+StxFus
         ActM+X7h8Tfl09JUxq0f+UYUBYo25fDMGjHan62YMYgiVms/9R2nW2Rk4+hE2pVdjs1w
         /rq27lnKNmU3ysj56re0roanpbnMgMtFn4bK0gzPGtiL2D3/z0m2TFjwv3wwolRo56lw
         HXU5HyhsMNVBur82bEyEE6g1T9hDjEp/p3c1scwWG6UqV+uDM5We3b5Da6bhXJJMqbYF
         XVYVS6sYEutSjfa7zySeM/0UWBPTJAlJUlOV6m30qvJfsT/8TbL3p8oyeIfcoaLKpfrB
         GfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727099560; x=1727704360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxx15U318d5m06Ojgqj0DzpCwDVhOZTk+ahf/TNfxMI=;
        b=ckfIfJHVEIkKxJbzpbXaNKRy+JshVeHXNHUGtwSVwjGFQ6roeahlg5726uNPbPPKSX
         urSRPJDhMLo6S8TFFNG7KspiGEhPaMsTiCHEP7nzUkgZSw5uNZPxrkANNiDZUkmkZku9
         obIDfO5n7l1j8uToH4exPQEaf9wVAlWEYXEDFuw93YQJHWJFalcN3iCXpZXnvjhWapQ+
         Y8TlYiUuYfkNWIblddBe/vdZLLoabxMXUShRmimZTJXZkynxOIA3RoovxCHKokvvthKP
         w9z2vnNkpd18JAw32BiHvbFnEUyLeytpJ5ezP5eLpA2jx8qP6epgJ6HZcIqechx18DbP
         3q9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlXteG/8BEnGvESqEYpyQvAZOa7wa4f0hmvSLIxfE9galAcBNmJxAC2pG11dMLVKzAZNU/I1tKKxWae48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMyRkeXyX4yH2Z16nKURhuMfsAcjVtJUp/3HrS1/rMT+Kp1UJ/
	QF/jhO/DJIpXV4TKY4Uv4NS9ScCGkJtoPJMI/pHFLgC9q09ba+do
X-Google-Smtp-Source: AGHT+IFe8X0SbpSgKNuRyPiWx0QdObs6094mLsIqKsTi48MdfFgTfPlZc1tyUwDZcu51HvcImHFXvQ==
X-Received: by 2002:a05:6a00:1a90:b0:717:86ea:d010 with SMTP id d2e1a72fcca58-7199ca4d239mr15385128b3a.21.1727099559617;
        Mon, 23 Sep 2024 06:52:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a9ac0esm14347709b3a.14.2024.09.23.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:52:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] hexagon: vdso: Fix build failure
Date: Mon, 23 Sep 2024 06:52:35 -0700
Message-ID: <20240923135235.1159314-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hexagon images fail to build with the following error.

arch/hexagon/kernel/vdso.c:57:3: error: use of undeclared identifier 'name'
                name = "[vdso]",
                ^

Add the missing '.' to fix the problem.

Fixes: 497258dfafcc ("mm: remove legacy install_special_mapping() code")
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/hexagon/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/vdso.c b/arch/hexagon/kernel/vdso.c
index 6fd27ff1df73..8119084dc519 100644
--- a/arch/hexagon/kernel/vdso.c
+++ b/arch/hexagon/kernel/vdso.c
@@ -54,7 +54,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	static struct vm_special_mapping vdso_mapping = {
-		name = "[vdso]",
+		.name = "[vdso]",
 	};
 
 	if (mmap_write_lock_killable(mm))
-- 
2.45.2

