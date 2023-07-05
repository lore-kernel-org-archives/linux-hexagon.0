From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 08/12] drivers/firmware: Remove trailing whitespaces
Date: Wed, 05 Jul 2023 09:46:32 +0200
Message-ID: <87bkgqssvb.fsf@minerva.mail-host-address-is-not-set>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-9-tzimmermann@suse.de>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688543198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ErZ583UAFFXXktAwUkPKfSDXi8WyYfGqw8H1xV5E3EY=;
	b=Vkxn4uE4kYCtC98t+U66H9A4IBlpsKjFexrLq+ajAMh6ZIeVDH2pt5VCE1UjfSewtgVfnq
	tYOoGshE6qbv+tF3TYH8pCU7J1MIVOkFRZTzcbYOSnERSttRr1jug2UiWO2lC1aTLE0gQn
	SXuz+SPpCSsXoYDOYhpKp6nQeXbz+X4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688543198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ErZ583UAFFXXktAwUkPKfSDXi8WyYfGqw8H1xV5E3EY=;
	b=Vkxn4uE4kYCtC98t+U66H9A4IBlpsKjFexrLq+ajAMh6ZIeVDH2pt5VCE1UjfSewtgVfnq
	tYOoGshE6qbv+tF3TYH8pCU7J1MIVOkFRZTzcbYOSnERSttRr1jug2UiWO2lC1aTLE0gQn
	SXuz+SPpCSsXoYDOYhpKp6nQeXbz+X4=
In-Reply-To: <20230629121952.10559-9-tzimmermann@suse.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix coding style. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>


-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

