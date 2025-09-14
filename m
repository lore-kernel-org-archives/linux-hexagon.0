Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34426B755
	for <linux-hexagon@vger.kernel.org>; Sun, 14 Sep 2025 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822053; cv=none; b=T0/vv4ot8o6o4C8PJpMmXGyxqe9eHKzQB6Es+j9Xg+JqZOJIZLsB99BlhMiXeru/5T1wtE0V4Qodm57184dK+ddzCYKE11la5i9ZRAXYLciJOjPNVZjGVxlFgztjJSRz3QkcAWpqXVTLZFkaX7kDSSTOkfp3SdRj2eTKpRnHIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822053; c=relaxed/simple;
	bh=E3G8T/3zLMm3x5kad8USEbJCkxfjt487WTCm3NfxUQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHE88A4baxXREE7zPpmJ3rPPuv6/Z8Hyq45eY/XeDKAbhf6/kMRqCS8ijJZu/O1D7xBwyHVvGaf61UZCfWjS67cIdqrb5kTVzOFirUKiv+MeJWYG5/+CFr4dy4QTcJYPmrfZ2vrUthhDQcyFBu/5ikDpR7iD/keDDl+NIN64jvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7q9EjnF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7q9EjnF"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b042eb09948so660048366b.3
        for <linux-hexagon@vger.kernel.org>; Sat, 13 Sep 2025 20:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822048; x=1758426848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0YiDU4Bzw7IKNW2/fgCfvKW6iRx1DQ4l7Ssn455PQA=;
        b=m7q9EjnFFJXZKnnJWAuHewuPVuFM6vjLTLUvGfzyzdImBQ++EznbIWQrk7ZI2edCxN
         ABVvHSn4RknXX5w6azOwuYHGkiavtI++cDhw2VB+z9yMG4LKQot3louLK0jFpgqq1FWv
         Q78TRjdvR0Cw/rFvCF6EeApx0C0A+QEIwW3wsoRz53U0346Ms0IAbOFiBo7TQKjy2D0H
         6fAS2QfZ95SJNv8tL8ibrMA8/T7EUfTK9KZRsSZi0NwfZi/1IKHCtEKzDysYdoxQDCFa
         Jvp3JCGDTMjnFlQzVxYRvv7qTI5TjZp2QRR+sCsbevZnJUnSRA7koomaDueq5ksTsrH3
         uUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822048; x=1758426848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0YiDU4Bzw7IKNW2/fgCfvKW6iRx1DQ4l7Ssn455PQA=;
        b=xMU1Ny+ooGqnY5ybNV98YhLbKsfoHuVLGs6OwnWzBh/sqeGU+yzEmL7DgKD3tcBcMk
         EBhoOweR//6AkswMUyuq0x/bxuyqtGS8/yMgYbxhDucG8V1wjuVnbfsS+nl1bTk1+B5r
         kAr2zoXf/V6Jxj+AHzULP1+4XuHxfAcOkTaieoraNk5B4tvZnlBXiFQCrGAqYYtUJyPD
         7wPKYcHRcgHtxnPLVzYIeEUEgLTY3F3YweeLIOfTqmyc2Hq1qoqmggQIN+Ahngls4R0q
         /VspNc/vwBoQCrVU0wlpqMOV4VaoVyqQxJ86QhJQw16Lmy4a0Y15LnS7JBkHAhEDRY7g
         TOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr3o26Ch6MwIP8rn7Je2yMVeRbz3a2f6CMw1BrSE4hTC1OFV5xfIZj5SSygEDVHniCG3Kiiq2OpfbSGq1g@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/IJ+XC6Y7SiP9mzO777Ov5Y+dDmxn4aFAnSEdy84lLYLKt26
	fnHdIR35PJjF2JKqlQnIlyuepjUVHkhoM1say6zabCYLl+g8TKNHWReo
X-Gm-Gg: ASbGncsnzO10atlxay0CK4mUBv2P9pRyVyHIm+NdSZc8OoHeQvMPcOD1UtMGH4hTznI
	jvbOSgwkikhYqgCNU3uyXJinPldjiW1s/dKJ5XVwYp7pp22qfWFr1R9/2JM6v1oijqHKPR/56ps
	ghjINcEChAYFkMF6esJvFZdFgvDZeBtNC5Oa9NEcMBl3W/uk9th9ibRlZaIr/lwcIL59eTD+pWL
	LijiiANj2tdO+pz7bs77Gk7w9sLv+JOobgd7/G76v3YKRszJZD/it7Id3f6/PvxNGtMUfpW4OVz
	ulSJTG03z+MMfcwLl4A6CFPW6ri8yi+1ggISGV7P7gxOrdEq/82x0Dp1VKAAH3NFsaSltFe7+fi
	fsT4MazBUqK/rzVtEv6uVt8Rbtcs8Bw==
X-Google-Smtp-Source: AGHT+IEVLkeZlLSkzoTpPLzlBRvNTQ9m/bl133jXYp2zZldNvB+tlYKH8pXYzZ5ISfOO2+UjGM6RFg==
X-Received: by 2002:a17:907:e8d:b0:b0e:3d88:27fd with SMTP id a640c23a62f3a-b0e3d97e027mr75192266b.8.1757822048020;
        Sat, 13 Sep 2025 20:54:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07da7a8918sm303079766b.56.2025.09.13.20.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:54:07 -0700 (PDT)
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
Subject: [PATCH RESEND 44/62] doc: kernel-parameters: remove [RAM] from reserve_mem=
Date: Sun, 14 Sep 2025 06:54:02 +0300
Message-ID: <20250914035402.3670906-1-safinaskar@gmail.com>
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

This parameter has nothing to do with ramdisk

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a259f2bdba0f..0805d3ebc75a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6277,8 +6277,7 @@
 			them.  If <base> is less than 0x10000, the region
 			is assumed to be I/O ports; otherwise it is memory.
 
-	reserve_mem=	[RAM]
-			Format: nn[KMG]:<align>:<label>
+	reserve_mem=	Format: nn[KMG]:<align>:<label>
 			Reserve physical memory and label it with a name that
 			other subsystems can use to access it. This is typically
 			used for systems that do not wipe the RAM, and this command
-- 
2.47.2

