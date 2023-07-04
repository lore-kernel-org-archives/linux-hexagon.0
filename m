From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 03/12] sysfb: Do not include <linux/screen_info.h> from
 sysfb header
Date: Tue, 04 Jul 2023 18:26:29 +0200
Message-ID: <87cz17lk22.fsf@minerva.mail-host-address-is-not-set>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-4-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=34WDUy7i5Wh6wzgno2BpzJrVdO3ZEc6gTi4J4xLGMnI=; b=E3ky2KNH7IhC+I
	+VLXDaNdPzt66k+rXhvgzgTgViEqys6UsUHW3p2zGKpZqEw5KqAp33a6xZh2n1scalSA85UUZtZco
	HvBlwBoDdOov399qGFf5yNl8nzkMB+xkXO5NbeoaVUi8yA6bEnucMX+khC3Mziw8DoDYiVOT1/g9r
	mOCTTvb8Jf2w0DHdyUXzMXqfWUHM5aXrWE+JGzLgtv8Yx2RwD7EsA8tqMqWD10qIgglktoIOj2RBP
	D3x+sOUKGI/sB0OlrrT9og6/G4A/ISXHzIVBfpoxJD4sCUtn1maDUzgdaRs/ZMRKUljBRiQrOyTO8
	LNNI+10hpNwGi6yibYMg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688487993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3N/Gyf3beclIUSfPsZhAnE2wLloPptbf+HqX/lLqDWc=;
	b=fHw9FiyufPGlzK4AIgS0dgZSj76QR2FVKZvFvIluVIyEuP6f3F2l9lrIR/e7xDHUCo0DWG
	LtDrB9sZuGTrAaR8aaSfQoiN+gnQoz1dcDo/jLka8JWUNjX/woiMKkO0AMpZE+9Vz1vK2O
	XMYn5sTagth877zSew8hlnGG90Q13y8=
In-Reply-To: <20230629121952.10559-4-tzimmermann@suse.de>
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
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-arch@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The header file <linux/sysfb.h> does not need anything from
> <linux/screen_info.h>. Declare struct screen_info and remove
> the include statements.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat
