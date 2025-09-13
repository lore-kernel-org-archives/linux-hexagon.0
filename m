Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673691A0B15
	for <linux-hexagon@vger.kernel.org>; Sat, 13 Sep 2025 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757726309; cv=none; b=CggOBdm8aKfuOzMqRbXbx8w8TCAU8JT4iEBfA2nKHPWa0ESjXEbR0dQa9IBhggUFBg1UnUqqZPReLpFtrf7z9Hv4SaQhXhi+TtACT+PAX0NhG0jk8rGTt6TtIoSvT63urXqweBDbvuXA/Kfy7ENBXiGAAuoFZujzh19C8X2UOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757726309; c=relaxed/simple;
	bh=gqqGfNEIy1h395KAAal0EqVTqfHBZvgS53UXMAzAIg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaelP9VFiGA9s0GzRml1aK3w4MQqL70ts2ifLZcqWrYUwLP8vT99C4MyCau6cAAtQckrX8XfeFI95p4zQe+8g8mbe6+uCq+qJmzpdjvPyWvfhnhfTFg3k9SsjfMlIr6/R12mrqg+NkfjCroc+p9Qp1CcUWHo84X+TzpHx2QxxTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3MR3wRG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3MR3wRG"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so369261766b.2
        for <linux-hexagon@vger.kernel.org>; Fri, 12 Sep 2025 18:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757726305; x=1758331105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azZv/jvf6IRhG0wveCq5ECQcNHAHnPNLNif/IfsLlkA=;
        b=S3MR3wRGhC/kXLFi7tEzWsnegJT9EOlT9m/C/MFzc4mLffsb1zPxwJp1ys/R7WkKtu
         lGH2qDNYyTs5AoU//E0brWD5vIAIWB1n3FQosPRaK+QRoGA0DZdmhSh/3U5iRy8W4DJp
         Fenld0TY4Z6v7xbzE43yOvUjTFLByOJ5B4tAPAr4+lqeApOt2QlD3yf3593AS0fFkyGD
         QIRxGEpNIvRn18hyuD6Dfkz7pZwRQAb4wq9+5bZobdNclLuXePQzPiQWeZfPixQk4bNj
         mQU+cnszndYycrVnwj9dFqcHiTNWiRrAaiY+Wgi8p28YIcrLfiIHcIobM8FFJ7GF7SK9
         5mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757726305; x=1758331105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azZv/jvf6IRhG0wveCq5ECQcNHAHnPNLNif/IfsLlkA=;
        b=LBttqv6NXgi1AUS8Eh9XEvv3+UX+JG2cLmwMTMK+e5pBWa5GbwgRltZPVjQPXoDLi7
         ymbDR3/wSm5MjO2iNXXbyyEkiLBcQlxRRZR+ex1ahiduIz4OlqMRHhvqvYrqO5VuNDTG
         mH/HIZl9lH3vtEVCouSoA6OEP6iUX8AtOY7krG4/3ziy+5D81ODXVoZ2R2WAxSEyQI6+
         ggIcZ1vEkezJvdVtc1+HF/NsTbYZwxzYwDlgEvOkVK/FytMgdjA4GfUQ0oFvQLoDL6+3
         Jyb/NVgInhPye92GRYSIaJuXEWnpXyGNx0hBYpJntldtIYoj34TIYOJt8zf18oRXvRVt
         e7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUImuFoWbqnT0PblVQouPyDNJ4ECq7VMiIVKX22ImbAX+hvnTgnrdXmOWnJw8QsfQLln6c9K5nNLHc07q2X@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6riu40rpLe0BqToXn1YfANPkr61msFXEg+7nRuXCWTJ4sfTb/
	Q/xhwf1fzMwXFhL/wAuK55I4RhtCUgbvYGhOJL6v25547BP9bcj/02FG
X-Gm-Gg: ASbGncv5jJQnisD65y+5lXYTFhHWHWGMEZsOkMkyoCIV6ewcqYHo4SE257FHz48iiOb
	8IS2OT8eaA56HGYAc8giFjPKccpUQqwoHZmLZwYSMFjJbfnFJU5BmxdPsv35lsXTqTdS1fGUdPQ
	MuU+xJycH7JhUdOMS/+VYsrBWVUOryVWOHPFCtDx48AgZSQiuNciZ5d6uHOiHLyciyNQ2NnO5hp
	C4xCygrj54xL5Oww4TP12rnJXiJ8b840hIL8Ct0iOIdb/+WL/YwLpK1b4QKYA4pUGz2IQi05Ahj
	2iIVDQE+4+eUionytniZGrxv9/dtibKC/wj5LulaN5ArPfr9Vx06fi1+vjIlqe1dl7r1ZIYcIte
	G/oeCn1u2iiLVw4EkGSo=
X-Google-Smtp-Source: AGHT+IExQyu+Z7m4GD3MP2gVTN78xlktku98kUsQddou1aWuxY/hOtzAat6yYKAto7vnFggGkvcCIA==
X-Received: by 2002:a17:907:3f18:b0:b04:45e1:5929 with SMTP id a640c23a62f3a-b07c35cd746mr507554266b.28.1757726304508;
        Fri, 12 Sep 2025 18:18:24 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd309sm475244766b.53.2025.09.12.18.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:18:24 -0700 (PDT)
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
Subject: [PATCH RESEND 35/62] init: make mount_root_generic static
Date: Sat, 13 Sep 2025 00:38:14 +0000
Message-ID: <20250913003842.41944-36-safinaskar@gmail.com>
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
index 60ba8a633d32..c722351c991f 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -174,7 +174,7 @@ static int __init do_mount_root(const char *name, const char *fs,
 	return ret;
 }
 
-void __init mount_root_generic(char *name, char *pretty_name, int flags)
+static void __init mount_root_generic(char *name, char *pretty_name, int flags)
 {
 	struct page *page = alloc_page(GFP_KERNEL);
 	char *fs_names = page_address(page);
diff --git a/init/do_mounts.h b/init/do_mounts.h
index f3df9d697304..f291c30f7407 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -12,7 +12,6 @@
 #include <linux/task_work.h>
 #include <linux/file.h>
 
-void  mount_root_generic(char *name, char *pretty_name, int flags);
 void  mount_root(char *root_device_name);
 extern int root_mountflags;
 
-- 
2.47.2

