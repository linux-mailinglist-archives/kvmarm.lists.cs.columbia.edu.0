Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B4C803AF105
	for <lists+kvmarm@lfdr.de>; Mon, 21 Jun 2021 18:54:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E612407B0;
	Mon, 21 Jun 2021 12:54:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dTqRdg81WD6M; Mon, 21 Jun 2021 12:54:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EA82440642;
	Mon, 21 Jun 2021 12:54:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F2A0405EE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Jun 2021 12:54:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AXnh+wRQVOPU for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Jun 2021 12:54:11 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 563844019D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Jun 2021 12:54:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624294451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6zZE8akrhvGvHpQPlV5MKIUMKjEzy8+Ripv6n6JNYY=;
 b=fW7Mo9ND6ub6LGGRCgjSbkynPZkdJMzMIn8TAqO1PQkzFlHKocC5Nn5Mu7g3++x3uH9z+D
 3Rl3MX97V9+VxByKgss24c+vinxjtj9qVuF5UHCAHINlf9t/yJvIxqUmjrBZyIeuFKQ5ce
 gKqdxupMIZbmYIrXBJQyqhTKwDEI2VY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-ZWFd2njQM7C7ZM2zu5SGhA-1; Mon, 21 Jun 2021 12:54:09 -0400
X-MC-Unique: ZWFd2njQM7C7ZM2zu5SGhA-1
Received: by mail-wm1-f72.google.com with SMTP id
 k8-20020a05600c1c88b02901b7134fb829so1838958wms.5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Jun 2021 09:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V6zZE8akrhvGvHpQPlV5MKIUMKjEzy8+Ripv6n6JNYY=;
 b=G0YiByEZGBMvfN7y3pmVQjkkGHtWfdbCFGyWc2ZAJk/TPWex8BkywzMJ4RbbmeU+Xn
 hfdkRF6dFOKUOYfrA3ZUWivG5RXZ/69gChvhyNMJVDuWIQy1M/VPYy09lbpgge44f7Ws
 WsMEFxvkXD3kfLljKqqxgfr89/o8dxqqV6DkUGwwcccOgCT7j4xz1LzZUu5gNrEhaioI
 Hb5iaY3kFipkev9dmNVDaSFmFRkpfPqUVzRe4OLg0oS58Kk41x7bPOIVwTvh1bDukSnb
 dKTQ1TbfI6tWxkuKrPWyajPTkot56oVPvP9LFzefiecEyo5sDGhBMtoIS7hj035akEMF
 N6ZA==
X-Gm-Message-State: AOAM530bixy45AGbCVVWHZ4hzpvM2Wf3Uk1y1QBi4jFet3YZHNrcEjMv
 FLRHOfP4Vovmwb1nGLOOoYzhbGUH6stp7+oB7oEV99UUVUqIIoQ2gagVxFiJ765zdNHWQtaDm7L
 B9gabZuoo1YCaU9gThxB8me+V
X-Received: by 2002:adf:c790:: with SMTP id l16mr30126579wrg.121.1624294448748; 
 Mon, 21 Jun 2021 09:54:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFGKeK1C9aLsbZ5fRG1HBzWUJ6GrPEryjqbjN7Js4Yi7goQyQWGV98j24oQrMV7cmBtu0WdQ==
X-Received: by 2002:adf:c790:: with SMTP id l16mr30126528wrg.121.1624294448496; 
 Mon, 21 Jun 2021 09:54:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id p11sm8468508wre.57.2021.06.21.09.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jun 2021 09:54:07 -0700 (PDT)
To: Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>, LinuxMIPS
 <linux-mips@vger.kernel.org>, KVMPPC <kvm-ppc@vger.kernel.org>,
 LinuxS390 <linux-s390@vger.kernel.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>,
 Peter Shier <pshier@google.com>, Oliver Upton <oupton@google.com>,
 David Rientjes <rientjes@google.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 David Matlack <dmatlack@google.com>, Ricardo Koller <ricarkol@google.com>,
 Krish Sadhukhan <krish.sadhukhan@oracle.com>, Fuad Tabba <tabba@google.com>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20210618222709.1858088-1-jingzhangos@google.com>
 <20210618222709.1858088-3-jingzhangos@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v12 2/7] KVM: stats: Add fd-based API to read binary stats
 data
Message-ID: <0cde024e-a234-9a10-5157-d17ba423939e@redhat.com>
Date: Mon, 21 Jun 2021 18:54:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618222709.1858088-3-jingzhangos@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 19/06/21 00:27, Jing Zhang wrote:
> +/**
> + * kvm_stats_read() - Common vm/vcpu stats read function to userspace.

Common function to read from the binary statistics file descriptor.

> + * @id: identification string of the stats
> + * @header: stats header for a vm or a vcpu
> + * @desc: start address of an array of stats descriptors for a vm or a vcpu
> + * @stats: start address of stats data block for a vm or a vcpu
> + * @size_stats: the size of stats data block pointed by @stats
> + * @user_buffer: start address of userspace buffer
> + * @size: requested read size from userspace
> + * @offset: the start position from which the content will be read for the
> + *          corresponding vm or vcp file descriptor
> + *
> + * The file content of a vm/vcpu file descriptor is now defined as below:
> + * +-------------+
> + * |   Header    |
> + * +-------------+
> + * |  id string  |
> + * +-------------+
> + * | Descriptors |
> + * +-------------+
> + * | Stats Data  |
> + * +-------------+
> + * Although this function allows userspace to read any amount of data (as long
> + * as in the limit) from any position, the typical usage would follow below
> + * steps:
> + * 1. Read header from offset 0. Get the offset of descriptors and stats data
> + *    and some other necessary information. This is a one-time work for the
> + *    lifecycle of the corresponding vm/vcpu stats fd.
> + * 2. Read id string from its offset. This is a one-time work for the lifecycle
> + *    of the corresponding vm/vcpu stats fd.
> + * 3. Read descriptors from its offset and discover all the stats by parsing
> + *    descriptors. This is a one-time work for the lifecycle of the
> + *    corresponding vm/vcpu stats fd.
> + * 4. Periodically read stats data from its offset using pread.
> + *
> + * Return: the number of bytes that has been successfully read
> + */
> +ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
> +		       const struct _kvm_stats_desc *desc,
> +		       void *stats, size_t size_stats,
> +		       char __user *user_buffer, size_t size, loff_t *offset)


You can replace the header argument with just the number of descriptors, 
and then construct the header in the "if" statement below that copies it 
to userspace:

const struct kvm_stats_header kvm_vm_stats_header = {
	.name_size = KVM_STATS_NAME_SIZE,
	.num_desc = num_desc,
	.id_offset = size_header,
	.desc_offset = size_header + KVM_STATS_NAME_SIZE,
	.data_offset = size_header + KVM_STATS_NAME_SIZE +
		       size_desc,
};

Of course size_header can be assigned with sizeof (struct kvm_stats_header).

This removes the definition of the header in each architecture.

Paolo

> +{
> +	ssize_t len;
> +	ssize_t copylen;
> +	ssize_t remain = size;
> +	size_t size_desc;
> +	size_t size_header;
> +	void *src;
> +	loff_t pos = *offset;
> +	char __user *dest = user_buffer;
> +
> +	size_header = sizeof(*header);
> +	size_desc = header->num_desc * sizeof(*desc);
> +
> +	len = KVM_STATS_NAME_SIZE + size_header + size_desc + size_stats - pos;
> +	len = min(len, remain);
> +	if (len <= 0)
> +		return 0;
> +	remain = len;
> +
> +	/*
> +	 * Copy kvm stats header.
> +	 * The header is the first block of content userspace usually read out.
> +	 * The pos is 0 and the copylen and remain would be the size of header.
> +	 * The copy of the header would be skipped if offset is larger than the
> +	 * size of header. That usually happens when userspace reads stats
> +	 * descriptors and stats data.
> +	 */
> +	copylen = size_header - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)header + pos;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +
> +	/*
> +	 * Copy kvm stats header id string.
> +	 * The id string is unique for every vm/vcpu, which is stored in kvm
> +	 * and kvm_vcpu structure.
> +	 * The id string is part of the stat header from the perspective of
> +	 * userspace, it is usually read out together with previous constant
> +	 * header part and could be skipped for later descriptors and stats
> +	 * data readings.
> +	 */
> +	copylen = size_header + KVM_STATS_NAME_SIZE - pos;

Should use header->id_offset instead of size_header here and in the 
computation of src.

> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = id + pos - size_header;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +
> +	/*
> +	 * Copy kvm stats descriptors.
> +	 * The descriptors copy would be skipped in the typical case that
> +	 * userspace periodically read stats data, since the pos would be
> +	 * greater than the end address of descriptors
> +	 * (header->header.desc_offset + size_desc) causing copylen <= 0.
> +	 */
> +	copylen = header->desc_offset + size_desc - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)desc + pos - header->desc_offset;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +
> +	/* Copy kvm stats values */
> +	copylen = header->data_offset + size_stats - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = stats + pos - header->data_offset;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +
> +	*offset = pos;
> +	return len;
> +}

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
