From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 8/9] hyperv: avoid dependency on screen_info
Date: Wed, 19 Jul 2023 14:39:43 +0200
Message-ID: <20230719123944.3438363-9-arnd@kernel.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=exkWgSGSe006ohG6lqAInwuxIR/oDq43C/kZBZ+xvmk=; b=pSR4XlLINBGlYe
	VX02jweVzqTTSOnf+a2MzE0z9D/vp2wsGKNk/fF6xF7djxIv7JOinMjTcuWKDucl/pBkLGpS623u/
	r20X8H1hSqPG7Xqu9K3KFu3BgBonkrcKp1nCGmElndh5gaRMEW0ByjHaw1fqM99lf1n6qoSbM+yxT
	F7A/gY6+qOiex/nH3NktPrQPDj7EgPljYQQkOrtsmEYpJSdTUBdzBSVaSRAWMLAz130MyesTpMbW1
	/Y1+1bUjApRBYGr0OJ7HAG6kzzNS3BtfKrKYGvOBTSMyLOIR2BLYN2KowlBgByLT7jVzqg+24Va34
	ZwQ/sn8NCg01nl7428/A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689770491;
	bh=9fW6U6BHu4TUL4RWpVUJbdMggGEj9FTfMpLEh+DKB4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQx8YO5rdZGaGJpL2Tgt6DTW/RbyR/A8QofqucAc+4eXdqqSGZqRJ1SkbMDzh4BLI
	 2NLToZZIHIF9hyPL+Cyk9ib9veIe3JFCFQPNi1M5+29webS34B7tOY2yr6coi1kyR9
	 68cbQ5j1lku+Y3+WAYkMKAfJYmwUgtN18hZyJw7RPd8HjbKYCKDKOoyZuP0RMlDEPX
	 GCkx3VMGRM6F3nmHYu2QILv1caInSzegNyJm5qhaqJg/HU5Vh3+s6GYahBrXTRz+u2
	 q5NpRtNW4/xAU+AMW7Nj2hyg2oXsH5ekaaNx3M1dPNTw9WEqMuc5GB/KyGcnL8ktIs
	 NotTDXWPm4GSw==
In-Reply-To: <20230719123944.3438363-1-arnd@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guo Ren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Khalid Aziz <khalid@gonehiking.org>, Linus Walleij <linus.walleij@linaro.org>, Matt Turner <mattst88@gmail.com>

From: Arnd Bergmann <arnd@arndb.de>

The two hyperv framebuffer drivers (hyperv_fb or hyperv_drm_drv) access the
global screen_info in order to take over from the sysfb framebuffer, which
in turn could be handled by simplefb, simpledrm or efifb. Similarly, the
vmbus_drv code marks the original EFI framebuffer as reserved, but this
is not required if there is no sysfb.

As a preparation for making screen_info itself more local to the sysfb
helper code, add a compile-time conditional in all three files that relate
to hyperv fb and just skip this code if there is no sysfb that needs to
be unregistered.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 7 ++++---
 drivers/hv/vmbus_drv.c                  | 6 ++++--
 drivers/video/fbdev/hyperv_fb.c         | 8 ++++----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 8026118c6e033..9a44a00effc24 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -73,9 +73,10 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
 	struct drm_device *dev = &hv->dev;
 	int ret;
 
-	drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
-						     screen_info.lfb_size,
-						     &hyperv_driver);
+	if (IS_ENABLED(CONFIG_SYSFB))
+		drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
+							     screen_info.lfb_size,
+							     &hyperv_driver);
 
 	hv->fb_size = (unsigned long)hv->mmio_megabytes * 1024 * 1024;
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 67f95a29aeca5..5bc059e8a9f5f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2100,8 +2100,10 @@ static void __maybe_unused vmbus_reserve_fb(void)
 
 	if (efi_enabled(EFI_BOOT)) {
 		/* Gen2 VM: get FB base from EFI framebuffer */
-		start = screen_info.lfb_base;
-		size = max_t(__u32, screen_info.lfb_size, 0x800000);
+		if (IS_ENABLED(CONFIG_SYSFB)) {
+			start = screen_info.lfb_base;
+			size = max_t(__u32, screen_info.lfb_size, 0x800000);
+		}
 	} else {
 		/* Gen1 VM: get FB base from PCI */
 		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index b331452aab4fb..7e0d1c4235549 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1030,7 +1030,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 			goto getmem_done;
 		}
 		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
-	} else {
+	} else if (IS_ENABLED(CONFIG_SYSFB)) {
 		base = screen_info.lfb_base;
 		size = screen_info.lfb_size;
 	}
@@ -1076,13 +1076,13 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 getmem_done:
 	aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME);
 
-	if (gen2vm) {
+	if (!gen2vm) {
+		pci_dev_put(pdev);
+	} else if (IS_ENABLED(CONFIG_SYSFB)) {
 		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
 		screen_info.lfb_size = 0;
 		screen_info.lfb_base = 0;
 		screen_info.orig_video_isVGA = 0;
-	} else {
-		pci_dev_put(pdev);
 	}
 
 	return 0;
-- 
2.39.2
