Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601B1A238C
	for <linux-hexagon@vger.kernel.org>; Sat, 13 Sep 2025 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757726374; cv=none; b=fw5UzzsGVEbj31qzMIal24a9mp011/6OI7jwBMqEN4OkyTAKocrQQBZGPZXeiopz+Iom+sULPC5nxKYa5b7dMycj1RdDPv2HNpOgJUJ850OXtgcojzLDkJhOCif8RY4008kjSMcdFfFK6KUG5Z+td0lqtpnXDPhbHtGvZ92fG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757726374; c=relaxed/simple;
	bh=0dZBfgRsarIoSXxUVt0yhSx8VT0ilXZcRzH3UEVxVxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9WaSFN64xoXB3+h7i162fVaSlbYrqQXZBNlrGg0SiSObubZ71wprNEkfKao7khenYxcUO1021FRmGeje09T3uMXs+/p2bymp0ITYAmgEA9g+SebsBPBehoX0CR9CJEGzkjB1nyxzQWF+M37X4EtdjaCCoHfc76VRaZlA5iSa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdasfyAT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdasfyAT"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61d7b2ec241so3053475a12.0
        for <linux-hexagon@vger.kernel.org>; Fri, 12 Sep 2025 18:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757726370; x=1758331170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01GQX+A5wcxVOfa45EtHUSgPI4YB4B2sFvA+zw7J76I=;
        b=JdasfyATZKgVuDGioUqz8M95vHmUjDA0X+pQzxpf/9WU/t+U6Kr5Hnn8A/pwyQbEEj
         tG9d5C4koMLr9jbbHvOg3kmOIpnqmXdSH9FzLhmDOw7FKaw9Ew5j+I2E2DqtaAF0kBLZ
         78wviOrJLl+vWbv0yCaEb7FNWVwdYcrEt3ieIj7Euu12bhdJuyE+iXc5Pb1FYjgjb8hF
         cX5p4CCG19iBqFwJotgYe++od9U/7qY0/+Gz7PK70bhGuzPjXacGCU6LuDPtHZleKndu
         uaVp9WGOG3lboi/Y241AWiDrohHR47mki0UFwavjwS1g6Qe4yDpW5hurcQZvXGxBtRDc
         ssdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757726370; x=1758331170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01GQX+A5wcxVOfa45EtHUSgPI4YB4B2sFvA+zw7J76I=;
        b=a1ym+kcLau+m3EpxWBShzHYMryZQ4bgoY7ZniGmbkYzq64Fmsq36PIdc/pzBJa9+sm
         0SreK6OA1bM+PDXCRkHtia1kiInRk21AoyMTRwqM5l1ZQ9vK53jVHJAfqUfwZjQYCbuY
         QRbBdqCI4VRwxlviX/kF4Bx9odkYWTsdh+vhFm8Fy+q7I5TZB0QLJ4jSXL1oudeQExY/
         zGSiGkc7aZ/R1fuP/BmlEnvb70j4gHzvlUwteFr8JLnJfb3gSZg5J6BUeAfYiv2UjoYk
         OFppnud/Enu1Fr4eZcnCml8xMdiARaPX9IdQb2DYov3Zv0b/nakyeNpS7zXrHAE5MK/G
         mxUw==
X-Forwarded-Encrypted: i=1; AJvYcCWIwpz8k5uvYpD2E1JA/DvrcvnToCDMa2Lf0WCa2GHS48yiVbwe2nVY6dLqI4lDPaZ3RH7yv+Qz1QdtvHwN@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEjUgYF3/yse1cszoWOCOH7ruDaegQa8sgbqaMz66o4wzhHNa
	ea5+1dKp48ST6jQ5rGz9nv1KmEtbIR7C9LK1ik+nfNfhrIEyn/mwxT23
X-Gm-Gg: ASbGnctvF3CiAg9GQaXxHqQmITBlAcwCwZ4rbWASX83YblrOPmlEEGh5qp24oLtwR8n
	hGmVcLHpkiJhha4T6CXUuOftns6eCa0RK3aqe0wX7lG3N4vhpl9ElBCw1KugTs4rHdbMIDTLGUu
	DJQ263rKWfehIh1tsAIUaIR6/CtzwW8dAXfX96aI9h3hdxCXczdVgVnMW62uKpEiVAPqfCYwvQy
	FDSaEPFmg4zZ7hHAJOY2Jcuw4JG1NVFacCryBIdlcFJUfPyV+ApyiMoB6o5ifEdHpfg8eArDQwk
	kblH4v1WJw+jdG6VOQerdm/eFklmHQsO2db7xLA3qfQVTbB8Mgop06La3wxuMtMqaQQQzDi0lRp
	IHEsFI8TwD1d6u9GnpozP2y2CIde1cw==
X-Google-Smtp-Source: AGHT+IEzeVwYKpSq5hVwsza+AqQmwMGGceGxnApLyMFPwDCsoulMW4PoMJQ37ACnH/5BZ1euJLookQ==
X-Received: by 2002:a17:906:2493:b0:b04:9822:1ab4 with SMTP id a640c23a62f3a-b07c35fb2e4mr458597866b.27.1757726369974;
        Fri, 12 Sep 2025 18:19:29 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5bfsm465661666b.63.2025.09.12.18.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:19:29 -0700 (PDT)
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
Subject: [PATCH RESEND 36/62] init: make mount_root static
Date: Sat, 13 Sep 2025 00:38:15 +0000
Message-ID: <20250913003842.41944-37-safinaskar@gmail.com>
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
 init/do_mounts.c | 2 +-
 init/do_mounts.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index c722351c991f..7ec5ee5a5c19 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -381,7 +381,7 @@ static inline void mount_block_root(char *root_device_name)
 }
 #endif /* CONFIG_BLOCK */
 
-void __init mount_root(char *root_device_name)
+static void __init mount_root(char *root_device_name)
 {
 	switch (ROOT_DEV) {
 	case Root_NFS:
diff --git a/init/do_mounts.h b/init/do_mounts.h
index f291c30f7407..90422fb07c02 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -12,7 +12,6 @@
 #include <linux/task_work.h>
 #include <linux/file.h>
 
-void  mount_root(char *root_device_name);
 extern int root_mountflags;
 
 /* Ensure that async file closing finished to prevent spurious errors. */
-- 
2.47.2

