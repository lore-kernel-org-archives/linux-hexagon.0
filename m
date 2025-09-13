Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABC18991E
	for <linux-hexagon@vger.kernel.org>; Sat, 13 Sep 2025 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725973; cv=none; b=muDtAc0p/SS3vlgo48PRWl5+2WTpR5kTFpR1/GV831Y3qOryt4HUSGG+Sf6GRQoBXxXsIM/2K2VlQ0kjL4VMVTCmEwpsMPWKBXTuD/rAMulobV21h/6qaiEESfdq2NeDhE3bq/uwSMckh+2OvrJe3ACdbPnrpwQa8ouP5xYXlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725973; c=relaxed/simple;
	bh=5w1rh0L6NznGkqOB1ptiKwAFOGZfY5CoA2D4m8g2/Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHLw6zG7ZrDYh1asROaPTKKb9WM1uaCSJGoqb8jtdbW2VulhBYksyomiOrXEcJ0JokqYtgC4tfzdwEiFYk2qgqSfbKeC1l+lMzzHTvVxSHPO0P1Cvf7AUWf01HXjD7IK5/4cT1PX7NIQgw9Z/Vgva3BGwZ87gW/gtTStwuuSVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm9piSCy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm9piSCy"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b07c2908f3eso231542066b.1
        for <linux-hexagon@vger.kernel.org>; Fri, 12 Sep 2025 18:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725970; x=1758330770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPS175BLdkdbkMvPyh09bMwfY79gXnuJYPms+9/x8xc=;
        b=jm9piSCyAtXZ4sW7o/h3SGpliQHevBkrhxl1tQii9mgHqdG87o74LcSjtY0avpY0iX
         RdeiQDrUqQ5C5qyGy2HNHbhjeW1tyThLcjGIFDuhifBp9ZAahZRe/JcjT78TZLjYxr6O
         clz08Pl2eYNgCRP3z65VvP8bCDfsGkCIvdvYFwno6M8/UvygM+KRsZjpRUrxOekYWGnI
         j0/O25Qolp3eD7BmcFGNh8/jP3xJV+WM11QZFpJ3kUVpHKMxijbTHMgjsau/ncgLiR1/
         GlkR/1ri7/XijIi7U6mEk94bP2JEKshCIzyPHHSsIIuiNpAyZbMwdpQELhiCIBLbGIjK
         LxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725970; x=1758330770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPS175BLdkdbkMvPyh09bMwfY79gXnuJYPms+9/x8xc=;
        b=iwnU3B3uW0b3ykqDnJC5/fvDOesa7m0VllUAW8XC5E3ZyvFRQeQkQab/rBrJBo9AcS
         8X9ka6XafrlqKILahWG+SUcuuz/7loYZ2HMshL5A2NWXlibj/aZjhewNc1jdgJ+IfKTJ
         hkYMEtZJ7yS/K/DIoJ5irK1dFyQXMEQTgHW0SIaWqLSxXsNaCTVpZk3w1WkwJm2n697C
         V35UD00+rd9bFuyL1Q23otgUbR0Ss86/Yqw4xbeflfopRHywhRim0E0Jp2hliiudKFuO
         6usaPGI21tpETemV+ZlN0g3iG4Q8tKlWL4tmJuCgaRdds5rnDEpGPx4HXK5Gz4sEGomA
         AyIg==
X-Forwarded-Encrypted: i=1; AJvYcCX7GLcoUsyQoOWvy27iMaHGnRqzI15HzsfQEiwbGDi/1wJ2Zirk8HDYq0DlnfRNjayxNm8UhoJkTA3jhCxT@vger.kernel.org
X-Gm-Message-State: AOJu0YzqcaLwpPAXffzLaPfr933KTf+WMJdWgo6gjs513b+9+7n6frJb
	fIb5Wm4SqaTrirBiZzmLzrPnfkJ2n88/shZxbyEIpwhfrAz2u+XsmlaD
X-Gm-Gg: ASbGncvhKlwgusiJxrGGpbpOzmwOfesfooa9jDhPdAfPZHTjq1swYlh5vQGPFScNfxS
	Nfzom9Zqk8/6W/U8PlkmvKNF5+cY6sy2NvY3VJjEitfCmIxm+FqEla0I6hPoFnVL00M9Mkhjs/W
	ofm1Tjlw3RNJh285q5CqosUKaOwrYZlLU4oP8Shqpbv2cgcWdVDVcL+tx08kcw7O1Xbousq0PZ9
	FHhcC37ujtkImooI7EmzcO/6Pc9mLfOpK+KsdKrGIUIRZq87MIRAZXK7BULYh7/l1mWKXgEAJQI
	4whDllh8HppPqj0GahW3sDmRisVH0Ill3OJ/UhWzEOQDZBBbu/UdLKUfqF1QUHMWOAJBRo2CBhM
	Ovwy3Xm9oxzP2jgLDsrjYFLvLHeIp3etmguTQPtB8
X-Google-Smtp-Source: AGHT+IExCbHobezsJZBylPatDCb3rXiTmvHjuHynF55nxxCc14bpP2oPLB71sx+Li40Hkl4GjqRelQ==
X-Received: by 2002:a17:907:97d2:b0:b04:31c6:a434 with SMTP id a640c23a62f3a-b07c324cf12mr467235966b.0.1757725969783;
        Fri, 12 Sep 2025 18:12:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b30da327sm479612566b.11.2025.09.12.18.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:12:49 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 30/62] doc: remove documentation for block device 4 0
Date: Sat, 13 Sep 2025 00:38:09 +0000
Message-ID: <20250913003842.41944-31-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It doesn't work. I tested this both in system booted
using initramfs and in system booted from real root
device directly

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/devices.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 27835389ca49..6ce0940233a8 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -138,12 +138,6 @@
 		number for BSD PTY devices.  As of Linux 2.1.115, this
 		is no longer supported.	 Use major numbers 2 and 3.
 
-   4 block	Aliases for dynamically allocated major devices to be used
-		when its not possible to create the real device nodes
-		because the root filesystem is mounted read-only.
-
-		   0 = /dev/root
-
    5 char	Alternate TTY devices
 		  0 = /dev/tty		Current TTY device
 		  1 = /dev/console	System console
-- 
2.47.2

