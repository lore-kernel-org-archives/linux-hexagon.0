From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 08/12] drivers/firmware: Remove trailing whitespaces
Date: Thu, 29 Jun 2023 13:45:47 +0200
Message-ID: <20230629121952.10559-9-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688041200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnbbGu1zMH1syDJirDMyTtBxk9C138IDNFMzmPrl3+w=;
        b=bo7SVurtRzf6nQUYeNtLdtPzbtB8L0YrwlE4sXHKNnAg7Cu2uGNYODuxBxpmRIunRpXcYS
        PWsewt1WIYrSj0EdEavb/uQo9L4N+Ib3vXbQzoQSDywNdXQfLB+/NLycoqViude3+m8B6u
        8xk8gg9YaloVKPax+pmspUavuXy32zQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688041200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnbbGu1zMH1syDJirDMyTtBxk9C138IDNFMzmPrl3+w=;
        b=AKURaBo/0ARnZtjd/p7sna/scgkTBT8fsQl7ZO4UmWIEUzy86Z4AHS/B3MZhegYy0IgKYj
        Phr0x7NmPveOpYDg==
In-Reply-To: <20230629121952.10559-1-tzimmermann@suse.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-arch@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd627..0432737bbb8b4 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -99,7 +99,7 @@ config EFI_PCDP
 	  You must also enable the appropriate drivers (serial, VGA, etc.)
 
 	  See DIG64_HCDPv20_042804.pdf available from
-	  <http://www.dig64.org/specifications/> 
+	  <http://www.dig64.org/specifications/>
 
 config DMIID
     bool "Export DMI identification via sysfs to userspace"
-- 
2.41.0

