Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 79F1438B8DA
	for <lists+kvmarm@lfdr.de>; Thu, 20 May 2021 23:14:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 089B74B693;
	Thu, 20 May 2021 17:14:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5mpN+cBzud8c; Thu, 20 May 2021 17:14:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CDBC4B5B5;
	Thu, 20 May 2021 17:14:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 670964B49B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 17:14:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gNhv9JLdz0Cy for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 May 2021 17:14:41 -0400 (EDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9906C4B490
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 17:14:41 -0400 (EDT)
Received: by mail-lf1-f50.google.com with SMTP id v8so21552522lft.8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zgjwN9rmESWkDTpYMJ9FM8+UKB/8PQhYuemaTNKdQrk=;
 b=DCbSDwgjsDhUZ+fXPZEtYWpgw2XWNlgL9t3gofvO+yD0np9C9WPJ8Mt6VW+VwEgLwX
 CZHiJSdX33FC6pnnlYwqdVAFpjRYXGSLRGW6bxxa4Lm2UBinnpluCzOOUIlzuh+N+Oai
 0xSc1G3zTaFt+42mFRi4t9WCK66iMqqCKsoz1rIqSXp14uQFEfiuEj29yeRu3NcRbyuQ
 PbtQUxgVUFMX1jHYrkywBi44mWNQ5YqInSlVYGb64u3Xlf0XDQvY/uTrTvYfC0zbKCce
 cWJWx0/alKNavGRSegeQ/Z3lMYk+zoKGR4OiaufEowN+BJb52ke9FIbwGe0b6OxJM3bo
 QVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zgjwN9rmESWkDTpYMJ9FM8+UKB/8PQhYuemaTNKdQrk=;
 b=guXn9UxmTw5I1x9rCK7yGWrRynkgXSjGESlhrjQccJD8W6x7KIJt87Tf4xYEghfiFO
 frojcxS+GyqLJR8asC1AzPDGdQK+FE7n5ZWIz7WGg1UOMjSsu/QO69xVy+peIdpHyLQP
 W4CbHWwNQGY3qDiGFn2/qqv5FPChcNr8tJw3hY+Pnb4wzsxlhBA0vlqkU15//RZ3GFDQ
 koiOZRznPVc8ZytudPTQ8pMgSwIaH1OdEdw+5cJRTAwOouStBbUfPOazNdL8J3DCtJcr
 oQM6pZTjCI+/2X02+vb9b55/yig+ThGRdurlQqgPwY9Nhvl66cgpR91uv4mKyNGq+IeS
 9Hvg==
X-Gm-Message-State: AOAM531J6TLivNhAbF99CXAJMfI+RvmKgNbWYuIR7nZX4igrRw3frKdP
 ByL/1rOJKg41YkZuY90q13Xm9qHLj0N3arQK+VeWTA==
X-Google-Smtp-Source: ABdhPJzMN05hahoYaYLreI7t+gMOonZGHNLcLzdVtYZR0Boy/2szfHvA8qACFgQc8n9lGnOJpVX4002x4Oyu+7Malhk=
X-Received: by 2002:ac2:4919:: with SMTP id n25mr4402841lfi.646.1621545279862; 
 Thu, 20 May 2021 14:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-3-jingzhangos@google.com> <YKXj3gHvUoLnojzB@google.com>
 <CAAdAUtieAd6kvrXBNXc1TfO84ZxQ4xM30Z_G5F9CoT2gxeGrLA@mail.gmail.com>
 <YKaxYZYQRp0/9f+A@google.com>
 <CAAdAUtiZxw9_qQ4eszsxSQmmL7j46LRhixL5zYttcOzL0da42Q@mail.gmail.com>
 <YKbLsICiX4iI+0AB@google.com>
In-Reply-To: <YKbLsICiX4iI+0AB@google.com>
From: Jing Zhang <jingzhangos@google.com>
Date: Thu, 20 May 2021 16:14:27 -0500
Message-ID: <CAAdAUtjBXykziWb2AR5=wb0sJMq9P4dL17X4m5O-nB6mZn1S_Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] KVM: stats: Add fd-based API to read binary stats
 data
To: Ricardo Koller <ricarkol@google.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 LinuxS390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
 Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Rientjes <rientjes@google.com>, KVMPPC <kvm-ppc@vger.kernel.org>,
 Jim Mattson <jmattson@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Shier <pshier@google.com>, LinuxMIPS <linux-mips@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, May 20, 2021 at 3:51 PM Ricardo Koller <ricarkol@google.com> wrote:
>
> On Thu, May 20, 2021 at 02:46:41PM -0500, Jing Zhang wrote:
> > Hi Ricardo,
> >
> > On Thu, May 20, 2021 at 1:58 PM Ricardo Koller <ricarkol@google.com> wrote:
> > >
> > > On Thu, May 20, 2021 at 12:37:59PM -0500, Jing Zhang wrote:
> > > > Hi Ricardo,
> > > >
> > > > On Wed, May 19, 2021 at 11:21 PM Ricardo Koller <ricarkol@google.com> wrote:
> > > > >
> > > > > On Mon, May 17, 2021 at 02:53:12PM +0000, Jing Zhang wrote:
> > > > > > Provides a file descriptor per VM to read VM stats info/data.
> > > > > > Provides a file descriptor per vCPU to read vCPU stats info/data.
> > > > > >
> > > > > > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > > > > > ---
> > > > > >  arch/arm64/kvm/guest.c    |  26 +++++
> > > > > >  arch/mips/kvm/mips.c      |  52 +++++++++
> > > > > >  arch/powerpc/kvm/book3s.c |  52 +++++++++
> > > > > >  arch/powerpc/kvm/booke.c  |  45 ++++++++
> > > > > >  arch/s390/kvm/kvm-s390.c  | 117 ++++++++++++++++++++
> > > > > >  arch/x86/kvm/x86.c        |  53 +++++++++
> > > > > >  include/linux/kvm_host.h  | 127 ++++++++++++++++++++++
> > > > > >  include/uapi/linux/kvm.h  |  50 +++++++++
> > > > > >  virt/kvm/kvm_main.c       | 223 ++++++++++++++++++++++++++++++++++++++
> > > > > >  9 files changed, 745 insertions(+)
> > > > > >
> > > > >
> > > > > > +static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
> > > > > > +                           size_t size, loff_t *offset)
> > > > > > +{
> > > > > > +     char id[KVM_STATS_ID_MAXLEN];
> > > > > > +     struct kvm_vcpu *vcpu = file->private_data;
> > > > > > +     ssize_t copylen, len, remain = size;
> > > > > > +     size_t size_header, size_desc, size_stats;
> > > > > > +     loff_t pos = *offset;
> > > > > > +     char __user *dest = user_buffer;
> > > > > > +     void *src;
> > > > >
> > > > > Nit. Better to do pointer arithmetic on a "char *".  Note that gcc and
> > > > > clang will do the expected thing.
> > > > >
> > > > > > +
> > > > > > +     snprintf(id, sizeof(id), "kvm-%d/vcpu-%d",
> > > > > > +                     task_pid_nr(current), vcpu->vcpu_id);
> > > > > > +     size_header = sizeof(kvm_vcpu_stats_header);
> > > > > > +     size_desc =
> > > > > > +             kvm_vcpu_stats_header.count * sizeof(struct _kvm_stats_desc);
> > > > > > +     size_stats = sizeof(vcpu->stat);
> > > > > > +
> > > > > > +     len = sizeof(id) + size_header + size_desc + size_stats - pos;
> > > > > > +     len = min(len, remain);
> > > > > > +     if (len <= 0)
> > > > > > +             return 0;
> > > > > > +     remain = len;
> > > > >
> > > > > If 'desc_offset' is not right after the header, then the 'len'
> > > > > calculation is missing the gap into account. For example, assuming there
> > > > > is a gap of 0x1000000 between the header and the descriptors:
> > > > >
> > > > >         desc_offset = sizeof(id) + size_header + 0x1000000
> > > > >
> > > > > and the user calls the ioctl with enough space for the whole file,
> > > > > including the gap:
> > > > >
> > > > >         *offset = 0
> > > > >         size = sizeof(id) + size_header + size_desc + size_stats + 0x1000000
> > > > >
> > > > > then 'remain' gets the wrong size:
> > > > >
> > > > >         remain = sizeof(id) + size_header + size_desc + size_stats
> > > > >
> > > > > and ... (more below)
> > > > >
> > > > > > +
> > > > > > +     /* Copy kvm vcpu stats header id string */
> > > > > > +     copylen = sizeof(id) - pos;
> > > > > > +     copylen = min(copylen, remain);
> > > > > > +     if (copylen > 0) {
> > > > > > +             src = (void *)id + pos;
> > > > > > +             if (copy_to_user(dest, src, copylen))
> > > > > > +                     return -EFAULT;
> > > > > > +             remain -= copylen;
> > > > > > +             pos += copylen;
> > > > > > +             dest += copylen;
> > > > > > +     }
> > > > > > +     /* Copy kvm vcpu stats header */
> > > > > > +     copylen = sizeof(id) + size_header - pos;
> > > > > > +     copylen = min(copylen, remain);
> > > > > > +     if (copylen > 0) {
> > > > > > +             src = (void *)&kvm_vcpu_stats_header;
> > > > > > +             src += pos - sizeof(id);
> > > > > > +             if (copy_to_user(dest, src, copylen))
> > > > > > +                     return -EFAULT;
> > > > > > +             remain -= copylen;
> > > > > > +             pos += copylen;
> > > > > > +             dest += copylen;
> > > > > > +     }
> > > > > > +     /* Copy kvm vcpu stats descriptors */
> > > > > > +     copylen = kvm_vcpu_stats_header.desc_offset + size_desc - pos;
> > > > >
> > > > > This would be the state at this point:
> > > > >
> > > > >         pos     = sizeof(id) + size_header
> > > > >         copylen = sizeof(id) + size_header + 0x1000000 + size_desc - (sizeof(id) + size_header)
> > > > >                 = 0x1000000 + size_desc
> > > > >         remain  = size_desc + size_stats
> > > > >
> > > > > > +     copylen = min(copylen, remain);
> > > > >
> > > > >         copylen = size_desc + size_stats
> > > > >
> > > > > which is not enough to copy the descriptors (and the data).
> > > > >
> > > > > > +     if (copylen > 0) {
> > > > > > +             src = (void *)&kvm_vcpu_stats_desc;
> > > > > > +             src += pos - kvm_vcpu_stats_header.desc_offset;
> > > > >
> > > > > Moreover, src also needs to take the gap into account.
> > > > >
> > > > >         src     = &kvm_vcpu_stats_desc + (sizeof(id) + size_header) - (sizeof(id) + size_header + 0x1000000)
> > > > >                 = &kvm_vcpu_stats_desc - 0x1000000
> > > > >
> > > > > Otherwise, src ends up pointing at the wrong place.
> > > > >
> > > > > > +             if (copy_to_user(dest, src, copylen))
> > > > > > +                     return -EFAULT;
> > > > > > +             remain -= copylen;
> > > > > > +             pos += copylen;
> > > > > > +             dest += copylen;
> > > > > > +     }
> > > > > > +     /* Copy kvm vcpu stats values */
> > > > > > +     copylen = kvm_vcpu_stats_header.data_offset + size_stats - pos;
> > > > >
> > > > > The same problem occurs here. There is a potential gap before
> > > > > data_offset that needs to be taken into account for src and len.
> > > > >
> > > > > Would it be possible to just ensure that there is no gap? maybe even
> > > > > remove data_offset and desc_offset and always place them adjacent, and
> > > > > have the descriptors right after the header.
> > > > >
> > > > I guess I didn't make it clear about the offset fields in the header block.
> > > > We don't create any gap here. In this implementation, kernel knows that
> > > > descriptor block is right after header block and data block is right after
> > > > descriptor block.
> > > > The reason we have offset fields for descriptor block and data block is
> > > > for flexibility and future potential extension. e.g. we might add another
> > > > block between header block and descriptor block in the future for some
> > > > other metadata information.
> > > > I think we are good here.
> > >
> > > Hi Jing,
> > >
> > > I realize they are adjacent right now, as the function wouldn't work if
> > > they weren't. My comment was more about code maintenance, what happens
> > > if the layout changes. This function depends on an asumption about a
> > > layout defined somewhere else. For example,
> > >
> > >         copylen = kvm_vm_stats_header.desc_offset + size_desc - pos;
> > >
> > > makes an assumption about desc_offset being set to:
> > >
> > >         .desc_offset = sizeof(struct kvm_stats_header),
> > >
> > > and if desc_offset is not exactly that, then the function doesn't
> > > explicitely fail and instead does unexpected things (probably undetected
> > > by tests).
> > >
> > > I think the solution is to just check the assumptions. Either an assert
> > > or just bail out with a warning:
> > >
> > >         /* This function currently depends on the following layout. */
> > >         if (kvm_vm_stats_header.desc_offset != sizeof(struct kvm_stats_header) ||
> > >                         kvm_vm_stats_header.data_offset != sizeof(struct kvm_stats_header) +
> > >                         sizeof(kvm_vm_stats_desc)) {
> > >                 warning(...);
> > >                 return 0;
> > >         }
> > >
> > I understand your concern. But whenever layout changes, the read function needs
> > to be updated anyway. The read function is actually the place to cook
> > the data layout
> > of the anonymous file.
>
> Could it be a good idea for header.data_offset and header.desc_offset to
> be set here (in the function)? so the function has full control of the
> file layout.
>
It is hard to do that since all those values are architecture dependent.
> > If the vm/vcpu stats header has an incorrect
> > offset value that is
> > defined in the read function, the test will complain about wrong stats
> > descriptor field
> > values usually.
> > Anyway, I will add more sanity tests in the selftest to cover the
> > potential risks.
> > Thanks.
> > > > > > +     copylen = min(copylen, remain);
> > > > > > +     if (copylen > 0) {
> > > > > > +             src = (void *)&vcpu->stat;
> > > > > > +             src += pos - kvm_vcpu_stats_header.data_offset;
> > > > > > +             if (copy_to_user(dest, src, copylen))
> > > > > > +                     return -EFAULT;
> > > > > > +             remain -= copylen;
> > > > > > +             pos += copylen;
> > > > > > +             dest += copylen;
> > > > > > +     }
> > > > > > +
> > > > > > +     *offset = pos;
> > > > > > +     return len;
> > > > > > +}
> > > > > > +
> > > > > >
> > > > >
> > > > >
> > > > >
> > > > > > +static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
> > > > > > +                           size_t size, loff_t *offset)
> > > > > > +{
> > > > >
> > > > > Consider moving the common code between kvm_vcpu_stats_read and this one
> > > > > into some function that takes pointers to header, desc, and data. Unless
> > > > > there is something vcpu or vm specific besides that.
> > > > >
> > > > Will do that, thanks.
> > > > > > +     char id[KVM_STATS_ID_MAXLEN];
> > > > > > +     struct kvm *kvm = file->private_data;
> > > > > > +     ssize_t copylen, len, remain = size;
> > > > > > +     size_t size_header, size_desc, size_stats;
> > > > > > +     loff_t pos = *offset;
> > > > > > +     char __user *dest = user_buffer;
> > > > > > +     void *src;
> > > > > > +
> > > > > > +     snprintf(id, sizeof(id), "kvm-%d", task_pid_nr(current));
> > > > > > +     size_header = sizeof(kvm_vm_stats_header);
> > > > > > +     size_desc = kvm_vm_stats_header.count * sizeof(struct _kvm_stats_desc);
> > > > > > +     size_stats = sizeof(kvm->stat);
> > > > > > +
> > > > > > +     len = sizeof(id) + size_header + size_desc + size_stats - pos;
> > > > > > +     len = min(len, remain);
> > > > > > +     if (len <= 0)
> > > > > > +             return 0;
> > > > > > +     remain = len;
> > > > > > +
> > > > > > +     /* Copy kvm vm stats header id string */
> > > > > > +     copylen = sizeof(id) - pos;
> > > > > > +     copylen = min(copylen, remain);
> > > > > > +     if (copylen > 0) {
> > > > > > +             src = (void *)id + pos;
> > > > > > +             if (copy_to_user(dest, src, copylen))
> > > > > > +                     return -EFAULT;
> > > > > > +             remain -= copylen;
> > > > > > +             pos += copylen;
> > > > > > +             dest += copylen;
> > > > > > +     }
> > > > > > +     /* Copy kvm vm stats header */
> > > > > > +     copylen = sizeof(id) + size_header - pos;
> > > > > > +     copylen = min(copylen, remain);
> > > > > > +     if (copylen > 0) {
> > > > > > +             src = (void *)&kvm_vm_stats_header;
> > > > > > +             src += pos - sizeof(id);
> > > > > > +             if (copy_to_user(dest, src, copylen))
> > > > > > +                     return -EFAULT;
> > > > > > +             remain -= copylen;
> > > > > > +             pos += copylen;
> > > > > > +             dest += copylen;
> > > > > > +     }
> > > > > > +     /* Copy kvm vm stats descriptors */
> > > > > > +     copylen = kvm_vm_stats_header.desc_offset + size_desc - pos;
> > > > > > +     copylen = min(copylen, remain);
> > > > > > +     if (copylen > 0) {
> > > > > > +             src = (void *)&kvm_vm_stats_desc;
> > > > > > +             src += pos - kvm_vm_stats_header.desc_offset;
> > > > > > +             if (copy_to_user(dest, src, copylen))
> > > > > > +                     return -EFAULT;
> > > > > > +             remain -= copylen;
> > > > > > +             pos += copylen;
> > > > > > +             dest += copylen;
> > > > > > +     }
> > > > > > +     /* Copy kvm vm stats values */
> > > > > > +     copylen = kvm_vm_stats_header.data_offset + size_stats - pos;
> > > > > > +     copylen = min(copylen, remain);
> > > > > > +     if (copylen > 0) {
> > > > > > +             src = (void *)&kvm->stat;
> > > > > > +             src += pos - kvm_vm_stats_header.data_offset;
> > > > > > +             if (copy_to_user(dest, src, copylen))
> > > > > > +                     return -EFAULT;
> > > > > > +             remain -= copylen;
> > > > > > +             pos += copylen;
> > > > > > +             dest += copylen;
> > > > > > +     }
> > > > > > +
> > > > > > +     *offset = pos;
> > > > > > +     return len;
> > > > > > +}
> > > > > > +
> > > > > > --
> > > > > > 2.31.1.751.gd2f1c929bd-goog
> > > > > >
> > > > > > _______________________________________________
> > > > > > kvmarm mailing list
> > > > > > kvmarm@lists.cs.columbia.edu
> > > > > > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> >
> > Jing
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
