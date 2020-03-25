From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [patch V3 03/20] usb: gadget: Use completion interface instead of open coding it
Date: Wed, 25 Mar 2020 10:37:57 +0200
Message-ID: <87blokde3e.fsf@kernel.org>
References: <20200321112544.878032781@linutronix.de> <20200321113241.043380271@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=u1JHVU3RAXWpWzxoEBTeSB/vNLewo28StJEFtqtyLoU=;
        b=atWEsClArOzGKdLN4osuAk7d+XSEIi82gzITfDKHYSAZ1c+WEd3Ip/J9eETstflnDX
         LqQd2q6Qz/8hg3HTYMLWyI1r/uM72eIqZfUXxCdkYr7yZws3ErK2kSKYsVGHg9Cm/mtf
         X32RT6WFx/DxNfiiCaK5OWiM6W7e7JeJWoOEDUpgi05XVpNAtJvKJtyzJhblBES6Z/65
         eVjEoRNppJWoaSaLMrUSnZYRRo6sbYBlTHOOD7K3R3s4Elu3PeBJ5C7L2ulwEL9qqsKz
         nUa//b6Qd9KEX8nStmeRXzWQurXqzw+nAWyASHspx5uRQOtfM4KAnUAZ5r+BnFZwaD/D
         axHw==
In-Reply-To: <20200321113241.043380271@linutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Joel Fernandes <joel@joelfernandes.org>, Oleg Nesterov <oleg@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-pci@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, Zhang Rui <rui.zha>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> ep_io() uses a completion on stack and open codes the waiting with:
>
>   wait_event_interruptible (done.wait, done.done);
> and
>   wait_event (done.wait, done.done);
>
> This waits in non-exclusive mode for complete(), but there is no reason to
> do so because the completion can only be waited for by the task itself and
> complete() wakes exactly one exlusive waiter.
>
> Replace the open coded implementation with the corresponding
> wait_for_completion*() functions.
>
> No functional change.
>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: linux-usb@vger.kernel.org

Do you want to carry it via your tree? If so:

Acked-by: Felipe Balbi <balbi@kernel.org>

Otherwise, let me know and I'll pick this patch.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl57GGUACgkQzL64meEa
mQY/phAAyKS/jK6b1hVevAPsOBS5Zyk+RBQmkmps/3C2lTyyturSmqT3TAMZyTZo
/HPtsvyUYn8RBI5Pa62mvcnGi+/Lmk76YzmUqn/VJRe+J8kjuFI6IoyT4uDxdUsB
qGTiuQ5qbV7Ft3fvLoEEbuyPZeDc/pbfFyK78ajdAYec4MGS8r12tWzhRZTRyRAG
4fb/PjPcfk8/9eTkdgnjgINZTiwT9YN7HWpEfajl3MhlYK9pZh/J7swRaYwZULBo
+eVd6a6ZYt0YLC8wVQ/kJ9Q3EttmWBwPJB4FIXMzYDkXx2Z898ZUKeIJ8IXlwKSh
CynbYGL7rNJQ+UDpVA8/y5Mqqnu3pAht/csgfrBxm/ukjkMphIDjpzuUaODgH5W3
Eb4EXNgvgspzEMgz6pv9INgPPh2tWRmBQex8qOLrs1xups+ZmhFSHGKCUs8hxlDj
Zk0U6Mce6mopXiCf2iVgrv9ItHlp4myA/HwWEub+LwOJi8tCt+vCjzXloWMx4Ha+
TNyxLHrqLaeTQoYgl1wJQMjIhmcrb9UMBaJ5FhKdaXAGfAeicPSzVqVHG/yl6nds
Z2cTMhW5kIxJDMAOuemeYZLY8PMzXrG5xHT7Da3yOzurIOmp2rhvhjpt9TpjKDLE
3qsBCaxpICoolHqV8bAov175RPtyVvv5zdyXWulMD/1c2kVYiiY=
=IAgh
-----END PGP SIGNATURE-----
--=-=-=--
