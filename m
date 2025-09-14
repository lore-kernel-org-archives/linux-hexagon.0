Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B226E6E1
	for <linux-hexagon@vger.kernel.org>; Sun, 14 Sep 2025 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822303; cv=none; b=i/O9mpXjbliuvfuLP+hpfQHP/HJOmypo0C+hOXfxl0qyp6Zugwx1osCQXEGFypCT02jF/NLfuB91jSNo4pzlVQ3yUUeV2GoUwnN7tM8siErdqRlk4FpQ2BiB7lCaituYChZH2Jfuf2SglDv0hw0v+fYwiXAAUiMDEqoHdCkjnJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822303; c=relaxed/simple;
	bh=FYF9OqnW1oqjULxwM3aAWnQiXFUGSps55/Nt+hFxJ0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAqIcm/zhGSSp3yk0O8YNnAV1XKpEliSt+F9cyiOR7J3GmdxylK7aBPpf+JML55Pi4bESzkANbNQCtWNv8aZ0Ql+mw4VqJyVMmVNMvRDYpG4XbFkPymJkjTdn+tD1MEgCF7TlRhUfCla73z8dkndgXgE+MhiQykbDTdAjOnt4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/oQyEMs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/oQyEMs"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6228de280ccso6257086a12.3
        for <linux-hexagon@vger.kernel.org>; Sat, 13 Sep 2025 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822300; x=1758427100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PVDclpYQ6Nji01yBeit38rRV0WhZ/F6Ahkj7S8LBJ4=;
        b=c/oQyEMsxO7MkMZOEln/WrmMMtQQaHGOaUmTlhzl8UKvpViP19zX+vSpeUbIp0zoqN
         EWelczGv47S6YykHlfkwVCxMPzDowp44X5bNmchBymdwK4tYbZ18wMZwJjkP7SOQE8pm
         BmlFPLyEun1RebxQEt+pdvgKODvYjB1vS5rak9WegcmWyRyOOiWNwf7KpFpECZTJhJv0
         2XekMJhx1WUpdbcUCPBo9hPMQ/6AXCgHyHrqkCD9fggpms2GkKKpvSlKZdyAu0Id1fIF
         Xlw8OZAZwLDm5B89DemFU0yVq1R7rHOG8Uw4nxvqTEy4Id0QBzTVpa6Q5BmR6v6/1tPT
         xdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822300; x=1758427100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PVDclpYQ6Nji01yBeit38rRV0WhZ/F6Ahkj7S8LBJ4=;
        b=Y+mlCifG4PRc3FJJQZ9lEtke7RHz1UU8lq6EBbpcdHDkE/IkHsapMyN6yia+LMR2Nz
         lcJ4swnKtNRf+7BOaBlyB5rLqgnLLNDtmGHU7VJT0q6v9X2MATVVr3x6XuGbpReB8pX1
         MhXaJAqLQx8UGpPZ72cJjOtk6+GACPkAogYAdSV98GjdgqlFbpjsMmpwSumeKX2XQAxG
         Q6Q6/BOITsU7BRshNOYvSCLWpe9TGGZF0hKfUTocgEHdHcejojAn+ognujt1u6tLfca3
         QifITX3Cq9LtG9/Dl686nlmnXe1i4ZOw9HthoahrCnxKchPJnCfkfAStit55wA3xSFjO
         zfCA==
X-Forwarded-Encrypted: i=1; AJvYcCWRwg6pKnxZ7OG7/0VbujNgJ5mrnApAUv6+lah7zZmXVTDDebSJRhlFnCrVpKz2e78pFxEdvOZWdXE2trhJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yze58UQW2ooJB1+Z/ypYRnH949duCy4+uyNM6aE0KX09//BMoWz
	RM3mYZtj0INK/MhRAbwHn73LNpDQjp+igS2gJsmbXXkFpFF9AGNGpFh+
X-Gm-Gg: ASbGnctCb6f1HmXIGo15bzfrE/Y4gtJ/Wij1IDQmRIIjGomiLloccqGeIYeVqUd+dxa
	u54hGh3dvMY4bi708wMcOeiqc1KI3HMjlarXUeEPcl0p7sPvf12PVzYJ7Td1uKL4inVmpkE1AoP
	Vcl6nTEuFxiYyFnCX8BiSVo3uv2HqgMX2siCfznL7fDeVw0md08kAuTvjX9SyYDqTel9LSdgtBi
	AQi0YFN9QSWD9noBfScVRiNE78h7VbKcKJPIkmnB716UqH8FItEqIFoSxjW/7N/89IrzCgauUeA
	vidnRVazs26vu+Cp2JW/WNdH4i4CfkiDdD6aw1LM/NettPrtqr2yBWxP9/pLXyPsGiK6WQvvF6I
	3r6Fjwlpif/L2QPn07io=
X-Google-Smtp-Source: AGHT+IEs7a72WksMtWatD4lSFnDxnNg7+5MS1D9GOkH6MKg4k8K6DTsXjCx54xq6hKPtDzIS4c8/bw==
X-Received: by 2002:a05:6402:42d2:b0:627:f47c:b199 with SMTP id 4fb4d7f45d1cf-62ed82599f7mr8759493a12.8.1757822299751;
        Sat, 13 Sep 2025 20:58:19 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62edb7d9cbbsm4735738a12.15.2025.09.13.20.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:58:18 -0700 (PDT)
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
Subject: [PATCH RESEND 51/62] init: rename get_boot_config_from_initrd to get_boot_config_from_initramfs
Date: Sun, 14 Sep 2025 06:58:14 +0300
Message-ID: <20250914035814.3752803-1-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index a42f1f0fce84..c535e0613df8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -264,7 +264,7 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static void * __init get_boot_config_from_initrd(size_t *_size)
+static void * __init get_boot_config_from_initramfs(size_t *_size)
 {
 	u32 size, csum;
 	char *data;
@@ -311,7 +311,7 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	return data;
 }
 #else
-static void * __init get_boot_config_from_initrd(size_t *_size)
+static void * __init get_boot_config_from_initramfs(size_t *_size)
 {
 	return NULL;
 }
@@ -420,7 +420,7 @@ static void __init setup_boot_config(void)
 	char *err;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
-	data = get_boot_config_from_initrd(&size);
+	data = get_boot_config_from_initramfs(&size);
 	/* If there is no bootconfig in initrd, try embedded one. */
 	if (!data)
 		data = xbc_get_embedded_bootconfig(&size);
@@ -479,7 +479,7 @@ static void __init exit_boot_config(void)
 static void __init setup_boot_config(void)
 {
 	/* Remove bootconfig data from initrd */
-	get_boot_config_from_initrd(NULL);
+	get_boot_config_from_initramfs(NULL);
 }
 
 static int __init warn_bootconfig(char *str)
-- 
2.47.2

