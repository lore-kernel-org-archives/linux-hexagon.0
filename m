From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 11/12] fbdev/core: Protect edid_info with CONFIG_ARCH_HAS_EDID_INFO
Date: Thu, 29 Jun 2023 13:45:50 +0200
Message-ID: <20230629121952.10559-12-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688041202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8M3t+sIilpS+dvhDHVydT9EOWn+SooUMabnf/LFMHbo=;
        b=ZbROsLIJAkfIR/+jRVLDcd83SvH5cZmugk8kZwgL9JSMI/gKbyQR3HtKCm4o42ShuZpYkk
        PpOlJkUDBbcOuQ/YbZW1LarrlsmuvA7IRfwyIlPCdp7XjLFZCUf5QkBgkeK4CAQiyu6q+p
        rHluDhQg1B0za6ZvhP208NqkrxcQvWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688041202;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8M3t+sIilpS+dvhDHVydT9EOWn+SooUMabnf/LFMHbo=;
        b=3Hj6UbEAQMoFiqqs75ilDIpvJONgA2he7Vj193adp37UYAYmUsCXwiE0RCS1+n5Jev4Itq
        c8ZFL5Xhnj0s4yAQ==
In-Reply-To: <20230629121952.10559-1-tzimmermann@suse.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-arch@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Randy Dunlap <rdunlap@infradead.org>

Guard usage of edid_info with CONFIG_ARCH_HAS_EDID_INFO instead
of CONFIG_X86. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/video/fbdev/core/fbmon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 35be4431f649a..9ae063021e431 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1480,17 +1480,19 @@ int fb_validate_mode(const struct fb_var_screeninfo *var, struct fb_info *info)
 		-EINVAL : 0;
 }
 
-#if defined(CONFIG_FIRMWARE_EDID) && defined(CONFIG_X86)
+#if defined(CONFIG_FIRMWARE_EDID)
 const unsigned char *fb_firmware_edid(struct fb_info *info)
 {
 	unsigned char *edid = NULL;
 
+#if defined(CONFIG_ARCH_HAS_EDID_INFO)
 	/*
 	 * We need to ensure that the EDID block is only
 	 * returned for the primary graphics adapter.
 	 */
 	if (fb_is_primary_device(info))
 		edid = edid_info.dummy;
+#endif
 
 	return edid;
 }
-- 
2.41.0

