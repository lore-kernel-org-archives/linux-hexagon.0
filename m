Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C931494DB
	for <linux-hexagon@vger.kernel.org>; Sat, 13 Sep 2025 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725578; cv=none; b=iiwTkqLqRO0B4myWCilWSREMzWIfFQMQjceOMn032W3Xp9BFo0OvnZaPjj+INGjhiL7GmZT/NVKmp3yj+rACCjAXMPQosGMiWEFrhc2BexfaPElsC+KYYYED8rHWRUgSX1aHlU6uuKs80AXTDrSrJ0f0YxJDwwlEqq3UwpthhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725578; c=relaxed/simple;
	bh=vklOel+wSCjK4qNA3bbVH6akiUZ5v6h3w1mLbg32yHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acIfRftrRrmjunpVXH0kLUnVZkVteuZZLBkxKoOVAGQLUlcoCbXZob74cRIbuAKIWM+jDy0Cf+N/E+RsrSAkCpyqugR7uk575qgMw/1eBciZ79RCp+QMuLTS3MyJU53eX0ZG0SxnzeMwCozkuuSSKmKqO/EwpwcHdojurzYRzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5jdjkTj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5jdjkTj"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso4278905a12.1
        for <linux-hexagon@vger.kernel.org>; Fri, 12 Sep 2025 18:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725575; x=1758330375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRKyxFwRI2Qz0k3ZoQpZ3VLrtZiB303jicB3H5rLu1o=;
        b=i5jdjkTjtptnVRTKu9gC1FGyG631gNTKOQcNNjiV1wIGpCO9LKpi2CJ2RQ0m8t4mDH
         ONVWomxhe69fjxeYMmICCmXv0Rr8TDz7s6BVZICN9NwGb1N7pNZmRqZGBcz40knM2HMI
         W7Ji8wqwO1cw0T53Aky2TLdNt7Ux9WDivWO8koeL4yJfRdO+vqooDEJ5hMj2vZ6iRCxO
         FLSx379lFdhQ1bMH9wAjwlrmjDNUBqy5D7r979gfnOOIkIHRqh07UgA4qY+vpqOY4JKM
         u+gd3SquikxVivxA1PhfxTy/48fwXe+t0GbKjBfMbOX3kk2O1YHm9m0ES0HTMJbOYUaG
         GRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725575; x=1758330375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRKyxFwRI2Qz0k3ZoQpZ3VLrtZiB303jicB3H5rLu1o=;
        b=m5zYfxmmwv3JFfpdT0JcQ6Ji6TzpwyNnhysAgq94YN/4v9K19K0EnhfmzYqts545HK
         mAJQ6acOoj+6fjAZ9aTX5/bnvXxaNI0a0LPozRSncWTehCtBHLmvdGBxw1oEFIrHFGPo
         UOIM9ydSMEusKu017q3u+FP40ZdZLt+bYJoExwuk1h9bDKEi45gvRyUPIW/vnq1ON/dD
         /gVpVj93rDSRctFWkmUTKBev4OL4mkgScFCr5EeAmSVlyzEUxU2ULW5yfe4fjQdLSYIp
         Qo2YG7CYlj+lBevyTY4N2W5BfoT0Qb91IOUdoxvlwIHaTWi6Rbv0AQQuyWFv8XDLB2Yi
         2qWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLrQNl1Mt3VbOHOF9yJmZt/wBDkly+GNwDxPqG5q5uFXMQlU5Ssisih5TMJ6LVD2uV3HvloCrMWPDloQoP@vger.kernel.org
X-Gm-Message-State: AOJu0YwK6id5kr8See635h4vC8NxqO82oCHwMKUK90OeQOw/3ccVGF29
	zM7Qde8LkKtZkmjrUe2i9AI37wNkUh9Im+cXzLv/qjTJVwzztP5ApmHI
X-Gm-Gg: ASbGncusDiTWPhLuRwJEB4kfPS8SH7fK/Kx9xCx8Ikz7muKXvztvo4+yBrowiK0wxD/
	7PlKlZzcItZ7Npy7Z7V4BNCe3CAbUr5lacFXIjdRjyXOoZ/+Q+uQF8y9w9UkpIKsa1X/fsgz4Dj
	O8iOM4/Rf/YtSqtMen6Q0gS8aEuYZgKYzJeqTNdrG+kFuKlJSVO88pHHQeGmO4fbJdNGAiyuarc
	kUZKEFw/L+jbQSbzV8KtzaveQpElwEBwzb2ojkTqFIMnwiYv3fBBqZcVPkhxISepuXQU+N+PNna
	E5Vo8FrDFmARuZfhMAOW2valtiAAlvW59eYyrMkSEzL0Ib8hg3RhuI8DH4R5YDFdkZ4u8N1xgOE
	qzd8nw8iflaD/mRAgu+IecjB9DNjQpg==
X-Google-Smtp-Source: AGHT+IFUls6LXsrCLze7uCxm9gIrKR+0qjIy+VauG9zkpfPwn7RwHzjJtZF9/Fq3L/RMfRZn925KxQ==
X-Received: by 2002:a17:907:c09:b0:b04:35c3:40b3 with SMTP id a640c23a62f3a-b07c384b024mr492655366b.15.1757725574734;
        Fri, 12 Sep 2025 18:06:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07d9e18c24sm112553466b.61.2025.09.12.18.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:06:14 -0700 (PDT)
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
Subject: [PATCH RESEND 24/62] init: remove wrong comment
Date: Sat, 13 Sep 2025 00:38:03 +0000
Message-ID: <20250913003842.41944-25-safinaskar@gmail.com>
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

This comment is wrong. free_initrd_mem may be called
with crashk_end and initrd_end as arguments

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 include/linux/initrd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index e49c7166dbb3..4080ba82d4c9 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -6,7 +6,6 @@
 /* 1 if it is not an error if initrd_start < memory_start */
 extern int initrd_below_start_ok;
 
-/* free_initrd_mem always gets called with the next two as arguments.. */
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
-- 
2.47.2

